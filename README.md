# .dotfiles

My personal development environment: **Fish** + **Neovim** + **Ghostty**
It uses GNU Stow for symlink management.

## Setup

```sh
git clone <repo> ~/.dotfiles

# Symlink configs
stow -d {path-to-dotfiles} -t ~ home
```

## Structure

```
home/.config/
├── fish/        # Shell config, functions, completions
├── nvim/        # Editor config, plugins, LSP, DAP
└── ghostty/     # Terminal config
```
