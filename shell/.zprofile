# ============================================================================
# .zprofile - Zsh Profile File
# ============================================================================
# This file is sourced by LOGIN zsh shells (terminal startup, ssh login)
# Load order: .zshenv → .zprofile → .zshrc → .zlogin
#
# What should go here:
# - Commands that should run once at login
# - Setting up environment variables for the session
# - Package manager initialization (Homebrew, NVM)
#
# What should NOT go here:
# - Commands that should run for every shell (use .zshenv)
# - Interactive shell settings (use .zshrc)
# - Aliases (use .zshrc)

# ============================================================================
# Homebrew
# ============================================================================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ============================================================================
# Node Version Manager (NVM)
# ============================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
