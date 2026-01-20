#!/usr/bin/env bash
#
# Dotfiles Installation Script
# Idempotent: Safe to run multiple times
#

set -e

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$DOTFILES_DIR/backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
FORCE=false
INTERACTIVE=true

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            echo -e "${BLUE}Running in dry-run mode (no changes will be made)${NC}"
            shift
            ;;
        --force)
            FORCE=true
            INTERACTIVE=false
            shift
            ;;
        --yes|-y)
            INTERACTIVE=false
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --dry-run    Preview changes without executing"
            echo "  --force      Skip confirmations, overwrite all"
            echo "  --yes, -y    Non-interactive mode (auto-confirm)"
            echo "  --help, -h   Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory not found at $DOTFILES_DIR${NC}"
    exit 1
fi

# Function to create a symlink
link_file() {
    local src="$1"
    local dest="$2"

    # Check if source exists
    if [ ! -e "$src" ]; then
        echo -e "${RED}✗ Source not found: $src${NC}"
        return 1
    fi

    # Check if destination already points to source (idempotent check)
    if [ -L "$dest" ] && [ "$(readlink "$dest")" == "$src" ]; then
        echo -e "${GREEN}✓ Already linked: $dest${NC}"
        return 0
    fi

    # If dry-run, just report what would happen
    if [ "$DRY_RUN" = true ]; then
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            echo -e "${YELLOW}Would backup and replace: $dest -> $src${NC}"
        else
            echo -e "${BLUE}Would create: $dest -> $src${NC}"
        fi
        return 0
    fi

    # Backup existing file/symlink if it exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$(basename "$dest")"

        # If destination is in a subdirectory, preserve structure
        local dest_subdir=$(dirname "${dest#$HOME/}")
        if [ "$dest_subdir" != "." ]; then
            mkdir -p "$BACKUP_DIR/$dest_subdir"
            backup_path="$BACKUP_DIR/$dest_subdir/$(basename "$dest")"
        fi

        cp -RL "$dest" "$backup_path" 2>/dev/null || true
        echo -e "${YELLOW}Backed up: $dest -> $backup_path${NC}"
        rm -rf "$dest"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Create symlink
    ln -s "$src" "$dest"
    echo -e "${GREEN}✓ Linked: $dest -> $src${NC}"
}

# Show banner
echo ""
echo "=========================================="
echo "  Dotfiles Installation"
echo "=========================================="
echo ""

if [ "$DRY_RUN" = true ]; then
    echo -e "${BLUE}DRY RUN MODE - No changes will be made${NC}"
    echo ""
fi

# Interactive confirmation
if [ "$INTERACTIVE" = true ] && [ "$DRY_RUN" = false ]; then
    echo "This will create symlinks from your home directory to $DOTFILES_DIR"
    echo "Existing files will be backed up to: $BACKUP_DIR"
    echo ""
    read -p "Continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo ""
fi

# Track if any backups were made
BACKUPS_MADE=false

# Define all symlinks to create
# Format: "source_relative_to_dotfiles|destination_in_home"
declare -a SYMLINKS=(
    "shell/.bashrc|.bashrc"
    "shell/.zshrc|.zshrc"
    "shell/.zshenv|.zshenv"
    "shell/.zprofile|.zprofile"
    "shell/.profile|.profile"
    "git/.gitconfig|.gitconfig"
    "git/config/ignore|.config/git/ignore"
    "tmux/.tmux.conf.local|.tmux.conf.local"
    "alacritty/alacritty.toml|.config/alacritty/alacritty.toml"
    "zed/settings.json|.config/zed/settings.json"
)

# Create symlinks
echo "Creating symlinks..."
echo ""

for item in "${SYMLINKS[@]}"; do
    IFS='|' read -r src_rel dest_rel <<< "$item"
    src="$DOTFILES_DIR/$src_rel"
    dest="$HOME/$dest_rel"

    if link_file "$src" "$dest"; then
        if [ -d "$BACKUP_DIR" ] && [ "$DRY_RUN" = false ]; then
            BACKUPS_MADE=true
        fi
    fi
done

echo ""
echo "=========================================="

if [ "$DRY_RUN" = true ]; then
    echo -e "${BLUE}Dry run complete. Run without --dry-run to apply changes.${NC}"
else
    echo -e "${GREEN}Installation complete!${NC}"

    if [ "$BACKUPS_MADE" = true ]; then
        echo ""
        echo -e "${YELLOW}Backups were created at: $BACKUP_DIR${NC}"
        echo "You can safely delete the backup directory once you've verified everything works."
    fi

    echo ""
    echo "Next steps:"
    echo "  1. Start a new shell session or run: exec zsh"
    echo "  2. Verify symlinks: ls -la ~/.zshrc ~/.gitconfig"
    echo "  3. Create ~/.zshrc.local for machine-specific settings (API keys, etc.)"
fi

echo "=========================================="
echo ""
