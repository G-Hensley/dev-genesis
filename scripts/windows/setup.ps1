#Requires -Version 5.1
<#
.SYNOPSIS
    First-time setup helper for dev-genesis template

.DESCRIPTION
    This script helps developers:
    - Choose which AI assistant(s) to configure
    - Remove configurations for unused assistants
    - Initialize git if needed
    - Provide next steps guidance

.EXAMPLE
    .\setup.ps1

.NOTES
    Requires: PowerShell 5.1+ or PowerShell Core 7+
#>

[CmdletBinding()]
param()

# Strict mode for better error handling
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

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
        "Step"    { Write-Host "[-] $Message" -ForegroundColor White }
    }
}

function Write-Banner {
    Write-Host ""
    Write-Host "=======================================================" -ForegroundColor Magenta
    Write-Host "                                                       " -ForegroundColor Magenta
    Write-Host "           dev-genesis Setup                           " -ForegroundColor Magenta
    Write-Host "   From idea to code in under 30 minutes               " -ForegroundColor Cyan
    Write-Host "                                                       " -ForegroundColor Magenta
    Write-Host "=======================================================" -ForegroundColor Magenta
    Write-Host ""
}

#endregion

#region Configuration

$Script:ProjectDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $Script:ProjectDir) {
    $Script:ProjectDir = (Get-Location).Path
}

$Script:AIFiles = @{
    "claude"    = ".claude"
    "claude_md" = "CLAUDE.md"
    "cursor"    = ".cursorrules"
    "copilot"   = ".github\copilot-instructions.md"
    "windsurf"  = ".windsurfrules"
}

$Script:SelectedAI = @{}

#endregion

#region Main Functions

function Test-ProjectDirectory {
    $readmePath = Join-Path $Script:ProjectDir "README.md"
    if (-not (Test-Path $readmePath)) {
        Write-ColorOutput "This doesn't appear to be a dev-genesis project." "Error"
        Write-ColorOutput "Please run this script from the project root." "Info"
        exit 1
    }
}

function Initialize-Git {
    Write-Host ""
    Write-ColorOutput "Checking Git initialization..." "Step"

    $gitDir = Join-Path $Script:ProjectDir ".git"
    if (Test-Path $gitDir) {
        Write-ColorOutput "Git already initialized" "Success"
        return
    }

    Write-Host ""
    $response = Read-Host "Git is not initialized. Initialize now? (Y/n)"

    if ($response -match "^[Nn]$") {
        Write-ColorOutput "Skipping Git initialization" "Warning"
        return
    }

    Push-Location $Script:ProjectDir
    try {
        git init
        Write-ColorOutput "Git repository initialized" "Success"

        $commitResponse = Read-Host "Create initial commit? (Y/n)"
        if ($commitResponse -notmatch "^[Nn]$") {
            git add .
            git commit -m "Initial commit from dev-genesis template

Project initialized with dev-genesis developer accelerator template

Includes:
- AI assistant configurations
- Issue templates and workflows
- Security policy
- Contributing guidelines
- Code quality tooling"
            Write-ColorOutput "Initial commit created" "Success"
        }
    }
    finally {
        Pop-Location
    }
}

function Select-AIAssistants {
    Write-Host ""
    Write-Host "Which AI assistant(s) will you use?" -ForegroundColor White
    Write-Host ""
    Write-Host "  1) Claude Code (Anthropic's CLI assistant)"
    Write-Host "  2) Cursor (AI-powered code editor)"
    Write-Host "  3) GitHub Copilot"
    Write-Host "  4) Windsurf (Codeium's AI editor)"
    Write-Host "  5) All of the above"
    Write-Host "  6) None (I'll configure manually)"
    Write-Host ""
    Write-Host "Enter your choices separated by spaces (e.g., '1 2 3')"
    $choices = Read-Host "Selection"

    foreach ($choice in $choices.Split(' ', [StringSplitOptions]::RemoveEmptyEntries)) {
        switch ($choice) {
            "1" {
                $Script:SelectedAI["claude"] = $true
                $Script:SelectedAI["claude_md"] = $true
            }
            "2" { $Script:SelectedAI["cursor"] = $true }
            "3" { $Script:SelectedAI["copilot"] = $true }
            "4" { $Script:SelectedAI["windsurf"] = $true }
            "5" {
                $Script:SelectedAI["claude"] = $true
                $Script:SelectedAI["claude_md"] = $true
                $Script:SelectedAI["cursor"] = $true
                $Script:SelectedAI["copilot"] = $true
                $Script:SelectedAI["windsurf"] = $true
            }
            "6" { } # None selected
            default {
                Write-ColorOutput "Invalid choice: $choice (ignoring)" "Warning"
            }
        }
    }
}

function Remove-UnusedConfigs {
    Write-Host ""
    Write-ColorOutput "Cleaning up unused AI configurations..." "Step"

    $removed = $false

    foreach ($ai in $Script:AIFiles.Keys) {
        $filePath = Join-Path $Script:ProjectDir $Script:AIFiles[$ai]

        if (-not $Script:SelectedAI.ContainsKey($ai) -or -not $Script:SelectedAI[$ai]) {
            if (Test-Path $filePath) {
                Write-Host ""
                $response = Read-Host "Remove $ai configuration ($($Script:AIFiles[$ai]))? (y/N)"

                if ($response -match "^[Yy]$") {
                    Remove-Item -Path $filePath -Recurse -Force
                    Write-ColorOutput "Removed $($Script:AIFiles[$ai])" "Success"
                    $removed = $true
                }
                else {
                    Write-ColorOutput "Kept $($Script:AIFiles[$ai])" "Info"
                }
            }
        }
        else {
            if (Test-Path $filePath) {
                Write-ColorOutput "$ai configuration ready: $($Script:AIFiles[$ai])" "Success"
            }
            else {
                Write-ColorOutput "$ai configuration not found: $($Script:AIFiles[$ai])" "Warning"
            }
        }
    }

    if (-not $removed) {
        Write-ColorOutput "No configurations removed" "Info"
    }
}

function Set-ProjectPersonalization {
    Write-Host ""
    Write-ColorOutput "Personalizing project files..." "Step"

    # Try to get GitHub username from gh CLI
    $githubUser = ""
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        try {
            $authStatus = gh auth status 2>&1
            if ($LASTEXITCODE -eq 0) {
                $githubUser = gh api user --jq '.login' 2>$null
            }
        }
        catch { }
    }

    if ([string]::IsNullOrEmpty($githubUser)) {
        $githubUser = Read-Host "Enter your GitHub username"
    }
    else {
        $inputUser = Read-Host "GitHub username [$githubUser]"
        if (-not [string]::IsNullOrEmpty($inputUser)) {
            $githubUser = $inputUser
        }
    }

    # Get project name
    $projectName = Split-Path $Script:ProjectDir -Leaf
    $inputName = Read-Host "Project name [$projectName]"
    if (-not [string]::IsNullOrEmpty($inputName)) {
        $projectName = $inputName
    }

    # Update CODEOWNERS
    $codeownersPath = Join-Path $Script:ProjectDir ".github\CODEOWNERS"
    if (Test-Path $codeownersPath) {
        $content = Get-Content $codeownersPath -Raw
        $content = $content -replace "@OWNER", "@$githubUser"
        Set-Content -Path $codeownersPath -Value $content -NoNewline
        Write-ColorOutput "Updated CODEOWNERS" "Success"
    }

    # Update config.yml
    $configPath = Join-Path $Script:ProjectDir ".github\ISSUE_TEMPLATE\config.yml"
    if (Test-Path $configPath) {
        $content = Get-Content $configPath -Raw
        $content = $content -replace "OWNER/REPO", "$githubUser/$projectName"
        Set-Content -Path $configPath -Value $content -NoNewline
        Write-ColorOutput "Updated issue template config" "Success"
    }

    # Update LICENSE
    $licensePath = Join-Path $Script:ProjectDir "LICENSE"
    if (Test-Path $licensePath) {
        $currentYear = (Get-Date).Year
        $content = Get-Content $licensePath -Raw
        $content = $content -replace "\[YEAR\]", $currentYear
        $content = $content -replace "\[COPYRIGHT_HOLDER\]", $githubUser
        Set-Content -Path $licensePath -Value $content -NoNewline
        Write-ColorOutput "Updated LICENSE" "Success"
    }

    Write-Host ""
    Write-ColorOutput "Project personalized for @$githubUser/$projectName" "Success"
}

function Show-NextSteps {
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor White
    Write-Host "                    Setup Complete!                             " -ForegroundColor Green
    Write-Host "================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor White
    Write-Host ""
    Write-Host "  1. " -NoNewline; Write-Host "Update README.md" -ForegroundColor Cyan
    Write-Host "     Replace template content with your project description"
    Write-Host ""
    Write-Host "  2. " -NoNewline; Write-Host "Configure repository settings" -ForegroundColor Cyan
    Write-Host "     - Enable GitHub Discussions"
    Write-Host "     - Enable Private Vulnerability Reporting"
    Write-Host "     - Install the Settings app: https://github.com/apps/settings"
    Write-Host ""
    Write-Host "  3. " -NoNewline; Write-Host "Start planning your project" -ForegroundColor Cyan
    Write-Host "     Use the prompts in /prompts to:"
    Write-Host "     - Refine your idea (IDEA_REFINEMENT.md)"
    Write-Host "     - Generate project tasks (PROJECT_PLANNING.md)"
    Write-Host "     - Import tasks: .\scripts\windows\import-issues.ps1 issues.json"
    Write-Host ""
    Write-Host "  4. " -NoNewline; Write-Host "Read the documentation" -ForegroundColor Cyan
    Write-Host "     - docs/GETTING_STARTED.md - Quick start guide"
    Write-Host "     - docs/WORKFLOW.md - Full development workflow"
    Write-Host "     - docs/AI_ASSISTANTS.md - AI tool setup guides"
    Write-Host ""

    if ($Script:SelectedAI.ContainsKey("claude") -and $Script:SelectedAI["claude"]) {
        Write-Host "  5. " -NoNewline; Write-Host "Claude Code Commands" -ForegroundColor Cyan
        Write-Host "     Available commands in .claude/commands/:"
        Write-Host "     - /code-review - Comprehensive code review"
        Write-Host "     - /security-audit - Security vulnerability check"
        Write-Host "     - /performance-review - Performance analysis"
        Write-Host "     - /generate-tests - Generate test cases"
        Write-Host ""
    }

    Write-Host "Happy coding!" -ForegroundColor Green
    Write-Host ""
}

#endregion

#region Main

function Main {
    Write-Banner
    Test-ProjectDirectory

    Write-Host "Let's set up your project!" -ForegroundColor White

    # Step 1: Select AI assistants
    Select-AIAssistants

    # Step 2: Clean up unused configs
    Remove-UnusedConfigs

    # Step 3: Personalize project
    Set-ProjectPersonalization

    # Step 4: Initialize git
    Initialize-Git

    # Step 5: Show next steps
    Show-NextSteps
}

# Run main function
Main

#endregion
