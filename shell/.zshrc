export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="norm"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias v='nvim'
alias gg='lazygit'
alias rr='ranger'
alias p='pnpm'

eval "$(starship init zsh)"

# Sensitive API keys should be stored in ~/.zshrc.local (not tracked in git)
# Example: export OPENAI_API_KEY="your-key-here"

# Added by Windsurf
export PATH="/Users/krzysztofkalamarski/.codeium/windsurf/bin:$PATH"

alias claude="/Users/krzysztofkalamarski/.claude/local/claude"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# Load local machine-specific config (not tracked in git)
# Use this for sensitive API keys, tokens, and machine-specific settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
