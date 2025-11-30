#Requires -Version 5.1
<#
.SYNOPSIS
    Bulk create GitHub issues from a JSON file using GitHub CLI

.DESCRIPTION
    This script reads a JSON file containing issue definitions and creates
    them in the current GitHub repository using the GitHub CLI.

.PARAMETER JsonFile
    Path to the JSON file containing issues to create

.PARAMETER DryRun
    Preview issues without creating them

.PARAMETER Verbose
    Show detailed output

.EXAMPLE
    .\import-issues.ps1 issues.json

.EXAMPLE
    .\import-issues.ps1 -JsonFile issues.json -DryRun

.NOTES
    Requires:
    - GitHub CLI (gh) installed and authenticated
    - PowerShell 5.1+ or PowerShell Core 7+

    JSON Format:
    {
      "issues": [
        {
          "title": "Issue title",
          "body": "Issue description",
          "labels": ["label1", "label2"],
          "milestone": "Milestone name"
        }
      ]
    }
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$JsonFile,

    [Parameter()]
    [switch]$DryRun
)

# Strict mode for better error handling
Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

# Track labels we've already verified/created this session
$Script:VerifiedLabels = @{}

#region Helper Functions

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Type = "Info"
    )

    switch ($Type) {
        "Info"    { Write-Host "[i] $Message" -ForegroundColor Cyan }
        "Success" { Write-Host "[+] $Message" -ForegroundColor Green }
        "Warning" { Write-Host "[!] $Message" -ForegroundColor Yellow }
        "Error"   { Write-Host "[x] $Message" -ForegroundColor Red }
    }
}

function Test-Dependencies {
    # Check for GitHub CLI
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        Write-ColorOutput "GitHub CLI (gh) is not installed." "Error"
        Write-Host "Install it from: https://cli.github.com/"
        exit 1
    }

    # Check if authenticated
    $authStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-ColorOutput "Not authenticated with GitHub CLI." "Error"
        Write-Host "Run 'gh auth login' to authenticate."
        exit 1
    }
}

function Get-RandomLabelColor {
    # Array of pleasant, readable colors for labels
    $colors = @(
        "0366d6"  # Blue
        "28a745"  # Green
        "6f42c1"  # Purple
        "e36209"  # Orange
        "d73a49"  # Red
        "0e8a16"  # Dark green
        "1d76db"  # Light blue
        "5319e7"  # Violet
        "fbca04"  # Yellow
        "b60205"  # Dark red
        "d93f0b"  # Orange red
        "c2e0c6"  # Light green
        "bfdadc"  # Light cyan
        "d4c5f9"  # Light purple
        "f9d0c4"  # Light pink
    )
    return $colors | Get-Random
}

function New-LabelIfMissing {
    param([string]$LabelName)

    # Skip if we already verified/created this label in this session
    if ($Script:VerifiedLabels.ContainsKey($LabelName)) {
        return $true
    }

    # Check if label exists
    $existingLabels = gh label list --json name 2>$null | ConvertFrom-Json
    $exists = $existingLabels | Where-Object { $_.name -eq $LabelName }

    if ($exists) {
        $Script:VerifiedLabels[$LabelName] = $true
        return $true
    }

    $color = Get-RandomLabelColor
    Write-ColorOutput "Creating missing label: $LabelName" "Info"

    try {
        $output = gh label create $LabelName --color $color 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "Created label: $LabelName" "Success"
            $Script:VerifiedLabels[$LabelName] = $true
            return $true
        }
        elseif ($output -match "already exists") {
            # Label was created by another process
            $Script:VerifiedLabels[$LabelName] = $true
            return $true
        }
        else {
            Write-ColorOutput "Could not create label: $LabelName" "Warning"
            $Script:VerifiedLabels[$LabelName] = $true
            return $false
        }
    }
    catch {
        Write-ColorOutput "Could not create label: $LabelName" "Warning"
        $Script:VerifiedLabels[$LabelName] = $true
        return $false
    }
}

function Confirm-LabelsExist {
    param([array]$Labels)

    if (-not $Labels -or $Labels.Count -eq 0) {
        return
    }

    foreach ($label in $Labels) {
        if (-not [string]::IsNullOrEmpty($label)) {
            New-LabelIfMissing -LabelName $label | Out-Null
        }
    }
}

function Get-OrCreateMilestone {
    param([string]$MilestoneName)

    if ([string]::IsNullOrEmpty($MilestoneName)) {
        return $null
    }

    # Check if milestone exists
    $milestones = gh api repos/:owner/:repo/milestones 2>$null | ConvertFrom-Json
    $existing = $milestones | Where-Object { $_.title -eq $MilestoneName }

    if ($existing) {
        return $existing.number
    }

    if ($DryRun) {
        Write-ColorOutput "Would create milestone: $MilestoneName" "Warning"
        return $null
    }

    Write-ColorOutput "Creating milestone: $MilestoneName" "Info"
    $result = gh api repos/:owner/:repo/milestones -X POST -f title="$MilestoneName" 2>$null | ConvertFrom-Json
    Write-ColorOutput "Created milestone #$($result.number): $MilestoneName" "Success"
    return $result.number
}

function New-GitHubIssue {
    param(
        [string]$Title,
        [string]$Body,
        [array]$Labels,
        [string]$Milestone,
        [int]$Index,
        [int]$Total
    )

    Write-Host ""
    Write-ColorOutput "[$Index/$Total] Processing: $Title" "Info"

    # Ensure all labels exist before creating the issue
    if (-not $DryRun -and $Labels -and $Labels.Count -gt 0) {
        Confirm-LabelsExist -Labels $Labels
    }

    # Build arguments
    $ghArgs = @("issue", "create", "--title", $Title)

    if (-not [string]::IsNullOrEmpty($Body)) {
        $ghArgs += @("--body", $Body)
    }

    if ($Labels -and $Labels.Count -gt 0) {
        $labelList = $Labels -join ","
        $ghArgs += @("--label", $labelList)
    }

    if (-not [string]::IsNullOrEmpty($Milestone)) {
        $milestoneNum = Get-OrCreateMilestone -MilestoneName $Milestone
        if ($milestoneNum -or -not $DryRun) {
            $ghArgs += @("--milestone", $Milestone)
        }
    }

    if ($DryRun) {
        Write-ColorOutput "Dry run - would create issue:" "Warning"
        Write-Host "  Title: $Title"
        if ($Labels -and $Labels.Count -gt 0) {
            Write-Host "  Labels: $($Labels -join ', ')"
        }
        if (-not [string]::IsNullOrEmpty($Milestone)) {
            Write-Host "  Milestone: $Milestone"
        }
        return $true
    }

    if ($VerbosePreference -eq 'Continue') {
        Write-Host "  Creating issue with $($ghArgs.Count) arguments..."
    }

    try {
        $issueUrl = & gh @ghArgs 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "Created: $issueUrl" "Success"
            return $true
        }
        else {
            Write-ColorOutput "Failed to create issue: $Title" "Error"
            Write-ColorOutput "Error: $issueUrl" "Error"
            return $false
        }
    }
    catch {
        Write-ColorOutput "Failed to create issue: $Title" "Error"
        Write-ColorOutput "Error: $_" "Error"
        return $false
    }
}

#endregion

#region Main

function Main {
    # Validate input file
    if (-not (Test-Path $JsonFile)) {
        Write-ColorOutput "File not found: $JsonFile" "Error"
        exit 1
    }

    # Check dependencies
    Test-Dependencies

    # Read and parse JSON
    try {
        $jsonContent = Get-Content $JsonFile -Raw | ConvertFrom-Json
    }
    catch {
        Write-ColorOutput "Invalid JSON file: $JsonFile" "Error"
        Write-ColorOutput "Error: $_" "Error"
        exit 1
    }

    # Get issue count
    $issues = $jsonContent.issues
    if (-not $issues -or $issues.Count -eq 0) {
        Write-ColorOutput "No issues found in JSON file." "Warning"
        exit 0
    }

    $totalIssues = $issues.Count

    # Print header
    Write-Host ""
    Write-Host "===========================================================" -ForegroundColor Cyan
    Write-Host "            GitHub Issues Import Tool                      " -ForegroundColor White
    Write-Host "===========================================================" -ForegroundColor Cyan
    Write-Host ""

    if ($DryRun) {
        Write-ColorOutput "DRY RUN MODE - No issues will be created" "Warning"
    }

    # Get repository info
    $repoInfo = gh repo view --json nameWithOwner 2>$null | ConvertFrom-Json
    Write-ColorOutput "Found $totalIssues issues to import" "Info"
    Write-ColorOutput "Repository: $($repoInfo.nameWithOwner)" "Info"
    Write-Host ""

    # Confirm before proceeding
    if (-not $DryRun) {
        $response = Read-Host "Do you want to continue? (y/N)"
        if ($response -notmatch "^[Yy]$") {
            Write-ColorOutput "Aborted." "Info"
            exit 0
        }
    }

    # Process issues
    $createdCount = 0
    $failedCount = 0
    $index = 1

    foreach ($issue in $issues) {
        $labels = @()
        if ($issue.labels) {
            $labels = @($issue.labels)
        }

        $success = New-GitHubIssue `
            -Title $issue.title `
            -Body $issue.body `
            -Labels $labels `
            -Milestone $issue.milestone `
            -Index $index `
            -Total $totalIssues

        if ($success) {
            $createdCount++
        }
        else {
            $failedCount++
        }

        $index++

        # Small delay to avoid rate limiting
        if (-not $DryRun) {
            Start-Sleep -Milliseconds 500
        }
    }

    # Print summary
    Write-Host ""
    Write-Host "===========================================================" -ForegroundColor Cyan
    Write-Host "                       Summary                             " -ForegroundColor White
    Write-Host "===========================================================" -ForegroundColor Cyan

    if ($DryRun) {
        Write-ColorOutput "Dry run complete. $totalIssues issues would be created." "Info"
    }
    else {
        Write-ColorOutput "Created: $createdCount issues" "Success"
        if ($failedCount -gt 0) {
            Write-ColorOutput "Failed: $failedCount issues" "Error"
        }
    }

    Write-Host ""
}

# Run main
Main

#endregion
