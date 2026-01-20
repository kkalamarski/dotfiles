# ============================================================================
# Zsh Configuration
# ============================================================================
# This file is sourced by interactive zsh shells
# For environment variables, use .zshenv
# For login shells, use .zprofile

# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="norm"

plugins=(
    git                    # Git aliases and completions
    docker                 # Docker aliases
    kubectl                # Kubernetes aliases
    tmux                   # Tmux integration
    npm                    # npm completion
    node                   # Node.js utilities
    rust                   # Rust/Cargo completions
    sudo                   # ESC ESC to add sudo
    command-not-found      # Suggest packages
    colored-man-pages      # Colorized man pages
)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# Prompt Configuration
# ============================================================================
eval "$(starship init zsh)"

# ============================================================================
# Path Management
# ============================================================================

# Windsurf editor
if [ -d "$HOME/.codeium/windsurf/bin" ]; then
    export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi

# Claude CLI
if [ -f "$HOME/.claude/local/claude" ]; then
    alias claude="$HOME/.claude/local/claude"
fi

# Python user binaries (auto-detect latest version)
if [ -d "$HOME/Library/Python" ]; then
    LATEST_PYTHON=$(ls -d "$HOME/Library/Python"/3.* 2>/dev/null | sort -V | tail -1)
    if [ -n "$LATEST_PYTHON" ] && [ -d "$LATEST_PYTHON/bin" ]; then
        export PATH="$LATEST_PYTHON/bin:$PATH"
    fi
fi

# ============================================================================
# Aliases
# ============================================================================

# Editor shortcuts
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Development tools
alias gg='lazygit'
alias rr='ranger'

# Package managers
alias p='pnpm'

# File operations
alias ll='ls -lAh'
alias la='ls -A'
alias l='ls -CF'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git shortcuts (supplement oh-my-zsh git plugin)
alias gs='git status'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'

# Project-specific
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# ============================================================================
# Shell Functions
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive format
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick git commit with message
gcom() {
    git add --all
    git commit -m "$1"
}

# Find files by name
ff() {
    find . -type f -iname "*$1*"
}

# Find directories by name
fd() {
    find . -type d -iname "*$1*"
}

# Display current PATH with each entry on a new line
path() {
    echo $PATH | tr ':' '\n'
}

# ============================================================================
# Machine-Specific Configuration
# ============================================================================

# Sensitive API keys should be stored in ~/.zshrc.local (not tracked in git)
# Example: export OPENAI_API_KEY="your-key-here"

# Load local machine-specific config (not tracked in git)
# Use this for sensitive API keys, tokens, and machine-specific settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
