# ============================================================================
# .zshenv - Zsh Environment File
# ============================================================================
# This file is sourced by ALL zsh shells (login, interactive, and scripts)
# Load order: .zshenv → .zprofile → .zshrc → .zlogin
#
# What should go here:
# - Environment variables needed by ALL shells
# - Variables that should be inherited by scripts
# - Critical PATH modifications
#
# What should NOT go here:
# - Interactive shell settings (use .zshrc)
# - Aliases (use .zshrc)
# - Terminal-specific configurations (use .zshrc)

# ============================================================================
# Rust/Cargo Environment
# ============================================================================
. "$HOME/.cargo/env"
