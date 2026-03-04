# Dotfiles

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

```sh
brew install stow
```

## Install

Clone the repo and stow the packages you want:

```sh
git clone <repo-url> ~/Projects/dotfiles
cd ~/Projects/dotfiles

# All packages
stow -t ~ aerospace git kitty nvim sketchybar tmux zsh

# Or pick individual ones
stow -t ~ nvim kitty
```

This creates symlinks from `~` pointing into the repo — edit files in one place, changes apply everywhere.

## Uninstall

```sh
cd ~/Projects/dotfiles
stow -t ~ -D <package>   # removes symlinks for that package
```

## Packages

| Package | What it configures |
|-|-|
| `aerospace` | AeroSpace tiling window manager |
| `git` | Git config |
| `kitty` | Kitty terminal |
| `nvim` | Neovim (LazyVim) |
| `sketchybar` | SketchyBar status bar |
| `tmux` | tmux |
| `zsh` | Zsh + Oh My Zsh |

## Adding a new package

```sh
mkdir -p ~/Projects/dotfiles/foo/.config/foo
mv ~/.config/foo/config ~/Projects/dotfiles/foo/.config/foo/
stow -t ~ foo
```

The directory structure inside each package mirrors where the files should land relative to `~`.
