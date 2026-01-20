# Dotfiles

Personal configuration files for shell, git, terminal, and editor setup.

## What's Included

This repository contains configuration for:

- **Shell** (.bashrc, .zshrc, .zshenv, .zprofile, .profile)
  - Zsh with oh-my-zsh integration
  - Starship prompt
  - Custom aliases (nvim, lazygit, ranger, pnpm)
  - Shopify Hydrogen development alias

- **Git** (.gitconfig, global gitignore)
  - User configuration
  - Global ignore patterns

- **Tmux** (.tmux.conf.local)
  - Custom tmux configuration (works with gpakosz/.tmux framework)

- **Alacritty** (alacritty.toml)
  - Terminal emulator configuration

## Quick Start

```bash
# Clone the repository
cd ~
git clone <your-repo-url> dotfiles

# Preview what will be installed
cd dotfiles
./install.sh --dry-run

# Install (creates symlinks)
./install.sh

# Start a new shell session
exec zsh
```

## Prerequisites

Before using these dotfiles, you should have the following installed:

### Required

- **Zsh** - Your default shell
- **oh-my-zsh** - Zsh framework
- **Homebrew** - Package manager for macOS
- **Starship** - Cross-shell prompt (`brew install starship`)

### Recommended Tools

- **Neovim** - Text editor (`brew install neovim`)
- **Lazygit** - Git TUI (`brew install lazygit`)
- **Ranger** - File manager (`brew install ranger`)
- **pnpm** - Fast npm alternative (`brew install pnpm`)
- **Alacritty** - GPU-accelerated terminal emulator (`brew install --cask alacritty`)
- **Tmux** - Terminal multiplexer (`brew install tmux`)
- **NVM** - Node version manager

## Installation Details

### File Mappings

The install script creates the following symlinks:

| Repository File | Home Directory Location |
|----------------|------------------------|
| `shell/.bashrc` | `~/.bashrc` |
| `shell/.zshrc` | `~/.zshrc` |
| `shell/.zshenv` | `~/.zshenv` |
| `shell/.zprofile` | `~/.zprofile` |
| `shell/.profile` | `~/.profile` |
| `git/.gitconfig` | `~/.gitconfig` |
| `git/config/ignore` | `~/.config/git/ignore` |
| `tmux/.tmux.conf.local` | `~/.tmux.conf.local` |
| `alacritty/alacritty.toml` | `~/.config/alacritty/alacritty.toml` |
| `.editorconfig` | `~/.editorconfig` |
| `.claude/settings.json` | `~/.claude/settings.json` |

### External Dependencies

Some configurations depend on external repositories that need to be set up separately:

#### oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### gpakosz/.tmux Framework

This is required for the tmux configuration to work:

```bash
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
# The .tmux.conf.local from this repo will be symlinked by install.sh
```

#### Neovim Configuration

Neovim configuration is managed in a separate repository:

**[kkalamarski/neovim-config](https://github.com/kkalamarski/neovim-config)**

See the repository for installation instructions and configuration details.

## Sensitive Data and Machine-Specific Settings

This repository does NOT contain sensitive data like API keys or tokens. For machine-specific or sensitive configuration:

### Using .zshrc.local for Secrets

Create a `~/.zshrc.local` file for machine-specific settings (this file is not tracked in git):

```bash
# ~/.zshrc.local
export OPENAI_API_KEY="your-key-here"
export OTHER_SECRET="your-secret"

# Machine-specific aliases
alias work='cd ~/work-projects'
```

The `.zshrc` automatically sources `~/.zshrc.local` if it exists.

### Pattern for Other Tools

You can use the same pattern for other configuration files:
- `.bashrc.local`
- `.zprofile.local`
- etc.

Files matching `*.local` are automatically ignored by git (see `.gitignore`).

## Install Script Options

```bash
# Preview changes without applying
./install.sh --dry-run

# Non-interactive mode (auto-confirm)
./install.sh --yes

# Skip confirmations and force overwrite
./install.sh --force

# Show help
./install.sh --help
```

### Idempotency

The install script is fully idempotent:
- Safe to run multiple times
- Skips symlinks that already point to the correct location
- Creates timestamped backups before overwriting files
- Never loses data

### Backups

When the script overwrites existing files, it creates backups in:
```
~/dotfiles/backup/YYYYMMDD_HHMMSS/
```

Once you've verified everything works, you can safely delete old backups.

## Updating Dotfiles

Since your home directory files are symlinked to the repository, you can edit them directly:

```bash
# Edit config (changes apply immediately)
vim ~/dotfiles/shell/.zshrc

# Commit changes
cd ~/dotfiles
git add -A
git commit -m "Update aliases"
git push
```

Or edit in place:
```bash
vim ~/.zshrc  # This edits ~/dotfiles/shell/.zshrc
cd ~/dotfiles && git add -A && git commit -m "Update"
```

## Adding New Dotfiles

1. Copy the file to the appropriate directory in `~/dotfiles`
2. Add a new entry to the `SYMLINKS` array in `install.sh`
3. Run `./install.sh` to create the new symlink
4. Commit the changes

Example:
```bash
# Add a new config file
cp ~/.config/newapp/config.toml ~/dotfiles/newapp/

# Edit install.sh and add to SYMLINKS array:
# "newapp/config.toml|.config/newapp/config.toml"

# Create the symlink
./install.sh

# Commit
git add -A && git commit -m "Add newapp config"
```

## Customization

### Themes

- Zsh theme: Set `ZSH_THEME` in `shell/.zshrc`
- Starship prompt: Create `~/.config/starship.toml` for customization

### Plugins

To add oh-my-zsh plugins, edit `shell/.zshrc`:
```bash
plugins=(git docker kubectl)
```

## Excluded from This Repository

The following are intentionally excluded:

- **Neovim config** (`~/.config/nvim/`) - Managed in [separate repository](https://github.com/kkalamarski/neovim-config)
- **Tmux framework** (`~/.tmux/`) - External repo (gpakosz/.tmux)
- **oh-my-zsh** (`~/.oh-my-zsh/`) - Third-party framework
- **SSH keys** (`~/.ssh/`) - Sensitive credentials
- **Version managers** (`.nvm`, `.cargo`, `.rustup`) - Too large/platform-specific
- **History files** - Contains sensitive command history
- **Cache and temp files** - Not portable

## Troubleshooting

### Symlinks not working

Check if symlinks are created correctly:
```bash
ls -la ~/.zshrc ~/.gitconfig
```

Should show:
```
~/.zshrc -> /Users/yourusername/dotfiles/shell/.zshrc
```

### Zsh theme not loading

Ensure oh-my-zsh is installed:
```bash
[ -d ~/.oh-my-zsh ] && echo "Installed" || echo "Not installed"
```

### Starship not showing

Install Starship:
```bash
brew install starship
```

### Tmux config not working

Ensure the gpakosz/.tmux framework is installed:
```bash
[ -L ~/.tmux.conf ] && echo "Installed" || echo "Not installed"
```

## License

Personal configuration files - use at your own risk.

## Author

Krzysztof Kalamarski
