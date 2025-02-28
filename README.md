# Dotfiles repository

Hi, this is my repository for dotfiles.

## Installation

1. Clone this repository

```bash
git clone https://github.com/matousekm/dotfiles.git ~/dotfiles
```

2. Install stow
```bash
brew install stow
```

3. Stow desired files
```bash
stow vim
```

## How it works

GNU stow organizes files using the `<package>/<expected_location>` naming convention. This way you can effectively version your dotfiles.

So `nvim/.config/nvim` means there is a package with name **nvim**. When someone stow such package, it should create a symlink at `~/.config/nvim` pointing to `~/dotfiles/nvim` or wherever you keep your stow packages at.

