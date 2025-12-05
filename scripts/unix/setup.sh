#!/usr/bin/env bash

#===============================================================================
# setup.sh
# First-time setup helper for dev-genesis template
#
# This script helps developers:
# - Choose which AI assistant(s) to configure
# - Remove configurations for unused assistants
# - Initialize git if needed
# - Provide next steps guidance
#
# Usage: ./scripts/setup.sh
#
# Note: Compatible with Bash 3.2+ (macOS default) - no associative arrays used
#===============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Print functions
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_step() { echo -e "${CYAN}→${NC} $1"; }

# Print banner
print_banner() {
    echo ""
    echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC}                                                               ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${NC}   ${BOLD}🚀 dev-genesis Setup${NC}                                        ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${NC}   ${CYAN}From idea to code in under 30 minutes${NC}                       ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}║${NC}                                                               ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# AI Assistant names and their configuration files (parallel arrays for Bash 3.2 compatibility)
# Note: Claude has two files (.claude/ directory and CLAUDE.md), both managed together
AI_NAMES=("claude" "cursor" "copilot" "windsurf")
AI_FILES=(".claude/" ".cursorrules" ".github/copilot-instructions.md" ".windsurfrules")
AI_LABELS=("Claude Code (Anthropic's CLI assistant)" "Cursor (AI-powered code editor)" "GitHub Copilot" "Windsurf (Codeium's AI editor)")

# Additional Claude file (CLAUDE.md) - managed alongside .claude/
CLAUDE_MD_FILE="CLAUDE.md"

# Track selected assistants (space-separated string for Bash 3.2 compatibility)
SELECTED_AI=""

# Helper function to check if an AI is selected
is_selected() {
    local ai="$1"
    case " $SELECTED_AI " in
        *" $ai "*) return 0 ;;
        *) return 1 ;;
    esac
}

# Helper function to get file path for an AI
get_ai_file() {
    local ai="$1"
    for i in "${!AI_NAMES[@]}"; do
        if [ "${AI_NAMES[$i]}" = "$ai" ]; then
            echo "${AI_FILES[$i]}"
            return
        fi
    done
}

# Check if running in the correct directory
check_directory() {
    if [ ! -f "$PROJECT_DIR/README.md" ]; then
        print_error "This doesn't appear to be a dev-genesis project."
        print_info "Please run this script from the project root or scripts directory."
        exit 1
    fi
}

# Initialize git if needed
init_git() {
    echo ""
    print_step "Checking Git initialization..."

    if [ -d "$PROJECT_DIR/.git" ]; then
        print_success "Git already initialized"
        return
    fi

    echo ""
    read -p "Git is not initialized. Initialize now? (Y/n) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        print_warning "Skipping Git initialization"
        return
    fi

    cd "$PROJECT_DIR"
    git init
    print_success "Git repository initialized"

    # Optionally create initial commit
    read -p "Create initial commit? (Y/n) " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        git add .
        git commit -m "Initial commit from dev-genesis template

🚀 Project initialized with dev-genesis developer accelerator template

Includes:
- AI assistant configurations
- Issue templates and workflows
- Security policy
- Contributing guidelines
- Code quality tooling"
        print_success "Initial commit created"
    fi
}

# Select AI assistants
select_ai_assistants() {
    echo ""
    echo -e "${BOLD}Which AI assistant(s) will you use?${NC}"
    echo ""
    echo "  1) ${AI_LABELS[0]}"
    echo "  2) ${AI_LABELS[1]}"
    echo "  3) ${AI_LABELS[2]}"
    echo "  4) ${AI_LABELS[3]}"
    echo "  5) All of the above"
    echo "  6) None (I'll configure manually)"
    echo ""
    echo "Enter your choices separated by spaces (e.g., '1 2 3')"
    read -p "Selection: " -r choices

    # Parse choices
    for choice in $choices; do
        case $choice in
            1) SELECTED_AI="${SELECTED_AI:+$SELECTED_AI }claude" ;;
            2) SELECTED_AI="${SELECTED_AI:+$SELECTED_AI }cursor" ;;
            3) SELECTED_AI="${SELECTED_AI:+$SELECTED_AI }copilot" ;;
            4) SELECTED_AI="${SELECTED_AI:+$SELECTED_AI }windsurf" ;;
            5) SELECTED_AI="claude cursor copilot windsurf" ;;
            6) ;; # None selected
            *)
                print_warning "Invalid choice: $choice (ignoring)"
                ;;
        esac
    done
}

# Remove unused AI configurations
cleanup_unused_configs() {
    echo ""
    print_step "Cleaning up unused AI configurations..."

    local removed=false

    for i in "${!AI_NAMES[@]}"; do
        local ai="${AI_NAMES[$i]}"
        local file="${AI_FILES[$i]}"
        local file_path="$PROJECT_DIR/$file"

        if ! is_selected "$ai"; then
            if [ -e "$file_path" ]; then
                echo ""
                read -p "Remove $ai configuration ($file)? (y/N) " -n 1 -r
                echo ""

                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    rm -rf "$file_path"
                    print_success "Removed $file"
                    removed=true

                    # Also remove CLAUDE.md if removing Claude configuration
                    if [ "$ai" = "claude" ] && [ -f "$PROJECT_DIR/$CLAUDE_MD_FILE" ]; then
                        rm -f "$PROJECT_DIR/$CLAUDE_MD_FILE"
                        print_success "Removed $CLAUDE_MD_FILE"
                    fi
                else
                    print_info "Kept $file"
                fi
            fi
        else
            if [ -e "$file_path" ]; then
                print_success "$ai configuration ready: $file"
                # Also check for CLAUDE.md when Claude is selected
                if [ "$ai" = "claude" ] && [ -f "$PROJECT_DIR/$CLAUDE_MD_FILE" ]; then
                    print_success "$ai configuration ready: $CLAUDE_MD_FILE"
                fi
            else
                print_warning "$ai configuration not found: $file"
            fi
        fi
    done

    if [ "$removed" = false ]; then
        print_info "No configurations removed"
    fi
}

# Update project files with user information
personalize_project() {
    echo ""
    print_step "Personalizing project files..."

    # Get GitHub username
    local github_user=""
    if command -v gh &> /dev/null && gh auth status &> /dev/null 2>&1; then
        github_user=$(gh api user --jq '.login' 2>/dev/null || echo "")
    fi

    if [ -z "$github_user" ]; then
        read -p "Enter your GitHub username: " github_user
    else
        read -p "GitHub username [$github_user]: " input_user
        github_user="${input_user:-$github_user}"
    fi

    # Get project name
    local project_name
    project_name=$(basename "$PROJECT_DIR")
    read -p "Project name [$project_name]: " input_name
    project_name="${input_name:-$project_name}"

    # Update CODEOWNERS
    if [ -f "$PROJECT_DIR/.github/CODEOWNERS" ]; then
        sed -i.bak "s/@OWNER/@$github_user/g" "$PROJECT_DIR/.github/CODEOWNERS"
        rm -f "$PROJECT_DIR/.github/CODEOWNERS.bak"
        print_success "Updated CODEOWNERS"
    fi

    # Update config.yml contact links
    if [ -f "$PROJECT_DIR/.github/ISSUE_TEMPLATE/config.yml" ]; then
        sed -i.bak "s|OWNER/REPO|$github_user/$project_name|g" "$PROJECT_DIR/.github/ISSUE_TEMPLATE/config.yml"
        rm -f "$PROJECT_DIR/.github/ISSUE_TEMPLATE/config.yml.bak"
        print_success "Updated issue template config"
    fi

    # Update LICENSE year and name
    if [ -f "$PROJECT_DIR/LICENSE" ]; then
        local current_year
        current_year=$(date +%Y)
        sed -i.bak "s/\[YEAR\]/$current_year/g" "$PROJECT_DIR/LICENSE"
        sed -i.bak "s/\[COPYRIGHT_HOLDER\]/$github_user/g" "$PROJECT_DIR/LICENSE"
        rm -f "$PROJECT_DIR/LICENSE.bak"
        print_success "Updated LICENSE"
    fi

    echo ""
    print_success "Project personalized for @$github_user/$project_name"
}

# Show next steps
show_next_steps() {
    echo ""
    echo -e "${BOLD}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}                        🎉 Setup Complete!${NC}"
    echo -e "${BOLD}════════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${BOLD}Next Steps:${NC}"
    echo ""
    echo "  1. ${CYAN}Update README.md${NC}"
    echo "     Replace template content with your project description"
    echo ""
    echo "  2. ${CYAN}Configure repository settings${NC}"
    echo "     - Enable GitHub Discussions"
    echo "     - Enable Private Vulnerability Reporting"
    echo "     - Install the Settings app: https://github.com/apps/settings"
    echo ""
    echo "  3. ${CYAN}Start planning your project${NC}"
    echo "     Use the prompts in /prompts to:"
    echo "     - Refine your idea (IDEA_REFINEMENT.md)"
    echo "     - Generate project tasks (PROJECT_PLANNING.md)"
    echo "     - Import tasks: ./scripts/unix/import-issues.sh issues.json"
    echo ""
    echo "  4. ${CYAN}Read the documentation${NC}"
    echo "     - docs/GETTING_STARTED.md - Quick start guide"
    echo "     - docs/WORKFLOW.md - Full development workflow"
    echo "     - docs/AI_ASSISTANTS.md - AI tool setup guides"
    echo ""

    if is_selected "claude"; then
        echo "  5. ${CYAN}Claude Code Commands${NC}"
        echo "     Available commands in .claude/commands/:"
        echo "     - /code-review - Comprehensive code review"
        echo "     - /security-audit - Security vulnerability check"
        echo "     - /performance-review - Performance analysis"
        echo "     - /generate-tests - Generate test cases"
        echo ""
    fi

    echo -e "${GREEN}Happy coding! 🚀${NC}"
    echo ""
}

# Main function
main() {
    print_banner
    check_directory

    echo -e "${BOLD}Let's set up your project!${NC}"

    # Step 1: Select AI assistants
    select_ai_assistants

    # Step 2: Clean up unused configs
    cleanup_unused_configs

    # Step 3: Personalize project
    personalize_project

    # Step 4: Initialize git
    init_git

    # Step 5: Show next steps
    show_next_steps
}

# Run main function
main "$@"
