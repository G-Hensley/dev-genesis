#!/usr/bin/env bash

#===============================================================================
# import-issues.sh
# Bulk create GitHub issues from a JSON file using GitHub CLI
#
# Usage: ./scripts/import-issues.sh <issues.json>
#
# JSON Format:
# {
#   "issues": [
#     {
#       "title": "Issue title",
#       "body": "Issue description",
#       "labels": ["label1", "label2"],
#       "milestone": "Milestone name"
#     }
#   ]
# }
#
# Requirements:
# - GitHub CLI (gh) installed and authenticated
# - jq installed for JSON parsing
#
# Note: Compatible with Bash 3.2+ (macOS default) - no associative arrays used
#===============================================================================

# Don't exit on error - we handle errors ourselves
set +e

# Track labels we've already created/verified this session (space-separated for Bash 3.2 compatibility)
VERIFIED_LABELS=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Helper function to check if a label has been verified
is_label_verified() {
    local label="$1"
    # Use a unique delimiter to avoid partial matches
    echo "$VERIFIED_LABELS" | grep -q "|${label}|"
}

# Helper function to mark a label as verified
mark_label_verified() {
    local label="$1"
    VERIFIED_LABELS="${VERIFIED_LABELS}|${label}|"
}

# Print usage
usage() {
    echo "Usage: $0 <issues.json>"
    echo ""
    echo "Bulk create GitHub issues from a JSON file."
    echo ""
    echo "Arguments:"
    echo "  issues.json    Path to JSON file containing issues"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -d, --dry-run  Preview issues without creating them"
    echo "  -v, --verbose  Show detailed output"
    echo ""
    echo "JSON Format:"
    echo '  {'
    echo '    "issues": ['
    echo '      {'
    echo '        "title": "Issue title",'
    echo '        "body": "Issue description",'
    echo '        "labels": ["label1", "label2"],'
    echo '        "milestone": "Milestone name"'
    echo '      }'
    echo '    ]'
    echo '  }'
    exit 1
}

# Generate a random color for labels
generate_label_color() {
    # Array of pleasant, readable colors for labels
    local colors=(
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
    echo "${colors[$RANDOM % ${#colors[@]}]}"
}

# Create a label if it doesn't exist
create_label_if_missing() {
    local label_name="$1"

    # Skip if we already verified/created this label in this session
    if is_label_verified "$label_name"; then
        return 0
    fi

    # Check if label exists in repo
    local existing_labels
    existing_labels=$(gh label list --json name -q ".[].name" 2>/dev/null)
    if echo "$existing_labels" | grep -qxF "$label_name"; then
        mark_label_verified "$label_name"
        return 0
    fi

    local color
    color=$(generate_label_color)

    print_info "Creating missing label: $label_name"
    local create_output
    create_output=$(gh label create "$label_name" --color "$color" 2>&1)
    local create_status=$?

    if [ $create_status -eq 0 ]; then
        print_success "Created label: $label_name"
        mark_label_verified "$label_name"
        return 0
    elif echo "$create_output" | grep -qi "already exists"; then
        # Label was created by another process or we missed it
        mark_label_verified "$label_name"
        return 0
    else
        print_warning "Could not create label: $label_name"
        # Still mark as verified to avoid repeated attempts
        mark_label_verified "$label_name"
        return 1
    fi
}

# Ensure all labels for an issue exist
ensure_labels_exist() {
    local labels="$1"

    if [ -z "$labels" ] || [ "$labels" = "null" ] || [ "$labels" = "[]" ]; then
        return 0
    fi

    # Iterate through each label
    local label
    while IFS= read -r label; do
        if [ -n "$label" ]; then
            create_label_if_missing "$label"
        fi
    done < <(echo "$labels" | jq -r '.[]')
}

# Check dependencies
check_dependencies() {
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) is not installed."
        echo "Install it from: https://cli.github.com/"
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        print_error "jq is not installed."
        echo "Install it with your package manager (e.g., 'brew install jq' or 'apt install jq')"
        exit 1
    fi

    # Check if authenticated
    if ! gh auth status &> /dev/null; then
        print_error "Not authenticated with GitHub CLI."
        echo "Run 'gh auth login' to authenticate."
        exit 1
    fi
}

# Get or create milestone
get_or_create_milestone() {
    local milestone_name="$1"

    if [ -z "$milestone_name" ]; then
        return
    fi

    # Check if milestone exists
    local milestone_number
    milestone_number=$(gh api repos/:owner/:repo/milestones --jq ".[] | select(.title == \"$milestone_name\") | .number" 2>/dev/null || echo "")

    if [ -z "$milestone_number" ]; then
        if [ "$DRY_RUN" = true ]; then
            print_warning "Would create milestone: $milestone_name"
        else
            print_info "Creating milestone: $milestone_name"
            milestone_number=$(gh api repos/:owner/:repo/milestones -X POST -f title="$milestone_name" --jq '.number')
            print_success "Created milestone #$milestone_number: $milestone_name"
        fi
    fi

    echo "$milestone_number"
}

# Create a single issue (using arrays for security - no eval)
create_issue() {
    local title="$1"
    local body="$2"
    local labels="$3"
    local milestone="$4"
    local index="$5"
    local total="$6"

    echo ""
    print_info "[$index/$total] Processing: $title"

    # Ensure all labels exist before creating the issue
    if [ "$DRY_RUN" = false ]; then
        ensure_labels_exist "$labels"
    fi

    # Build command arguments as an array (secure - no shell injection)
    local cmd_args=("issue" "create" "--title" "$title")

    if [ -n "$body" ]; then
        cmd_args+=("--body" "$body")
    fi

    if [ -n "$labels" ] && [ "$labels" != "null" ]; then
        # Convert JSON array to comma-separated string
        local label_list
        label_list=$(echo "$labels" | jq -r 'join(",")')
        if [ -n "$label_list" ]; then
            cmd_args+=("--label" "$label_list")
        fi
    fi

    if [ -n "$milestone" ] && [ "$milestone" != "null" ]; then
        local milestone_num
        milestone_num=$(get_or_create_milestone "$milestone")
        if [ -n "$milestone_num" ]; then
            cmd_args+=("--milestone" "$milestone")
        fi
    fi

    if [ "$DRY_RUN" = true ]; then
        print_warning "Dry run - would create issue:"
        echo "  Title: $title"
        [ -n "$labels" ] && [ "$labels" != "null" ] && echo "  Labels: $(echo "$labels" | jq -r 'join(", ")')"
        [ -n "$milestone" ] && [ "$milestone" != "null" ] && echo "  Milestone: $milestone"
    else
        if [ "$VERBOSE" = true ]; then
            echo "  Creating issue with ${#cmd_args[@]} arguments..."
        fi

        # Execute gh command with array expansion (secure)
        local issue_url
        if issue_url=$(gh "${cmd_args[@]}" 2>&1); then
            print_success "Created: $issue_url"
            CREATED_COUNT=$((CREATED_COUNT + 1))
        else
            print_error "Failed to create issue: $title"
            print_error "Error: $issue_url"
            FAILED_COUNT=$((FAILED_COUNT + 1))
        fi
    fi
}

# Main function
main() {
    # Parse arguments
    DRY_RUN=false
    VERBOSE=false
    JSON_FILE=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                ;;
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -*)
                print_error "Unknown option: $1"
                usage
                ;;
            *)
                JSON_FILE="$1"
                shift
                ;;
        esac
    done

    # Validate input
    if [ -z "$JSON_FILE" ]; then
        print_error "No JSON file specified."
        usage
    fi

    if [ ! -f "$JSON_FILE" ]; then
        print_error "File not found: $JSON_FILE"
        exit 1
    fi

    # Check dependencies
    check_dependencies

    # Validate JSON
    if ! jq empty "$JSON_FILE" 2>/dev/null; then
        print_error "Invalid JSON file: $JSON_FILE"
        exit 1
    fi

    # Get issue count
    local total_issues
    total_issues=$(jq '.issues | length' "$JSON_FILE")

    if [ "$total_issues" -eq 0 ]; then
        print_warning "No issues found in JSON file."
        exit 0
    fi

    # Print header
    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║            GitHub Issues Import Tool                     ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""

    if [ "$DRY_RUN" = true ]; then
        print_warning "DRY RUN MODE - No issues will be created"
    fi

    print_info "Found $total_issues issues to import"
    print_info "Repository: $(gh repo view --json nameWithOwner -q .nameWithOwner)"
    echo ""

    # Confirm before proceeding (unless dry run)
    if [ "$DRY_RUN" = false ]; then
        read -p "Do you want to continue? (y/N) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Aborted."
            exit 0
        fi
    fi

    # Initialize counters
    CREATED_COUNT=0
    FAILED_COUNT=0

    # Process each issue
    local index=1
    while IFS= read -r issue; do
        local title body labels milestone

        title=$(echo "$issue" | jq -r '.title')
        body=$(echo "$issue" | jq -r '.body // ""')
        labels=$(echo "$issue" | jq -c '.labels // []')
        milestone=$(echo "$issue" | jq -r '.milestone // ""')

        create_issue "$title" "$body" "$labels" "$milestone" "$index" "$total_issues"

        index=$((index + 1))

        # Small delay to avoid rate limiting
        if [ "$DRY_RUN" = false ]; then
            sleep 0.5
        fi
    done < <(jq -c '.issues[]' "$JSON_FILE")

    # Print summary
    echo ""
    echo "══════════════════════════════════════════════════════════"
    echo "                       Summary                            "
    echo "══════════════════════════════════════════════════════════"

    if [ "$DRY_RUN" = true ]; then
        print_info "Dry run complete. $total_issues issues would be created."
    else
        print_success "Created: $CREATED_COUNT issues"
        if [ "$FAILED_COUNT" -gt 0 ]; then
            print_error "Failed: $FAILED_COUNT issues"
        fi
    fi

    echo ""
}

# Run main function
main "$@"
