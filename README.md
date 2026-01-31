# .dotfiles

My personal development environment: **Fish** + **Neovim** + **Ghostty**
It uses GNU Stow for symlink management.

## Setup

```sh
git clone <repo> ~/.dotfiles

# Symlink configs
ln -s ~/.dotfiles/home/.config/fish ~/.config/fish
ln -s ~/.dotfiles/home/.config/nvim ~/.config/nvim
ln -s ~/.dotfiles/home/.config/ghostty ~/.config/ghostty
```

## Structure

```
home/.config/
├── fish/        # Shell config, functions, completions
├── nvim/        # Editor config, plugins, LSP, DAP
└── ghostty/     # Terminal config
```
