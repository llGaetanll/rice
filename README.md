# Rice

This repo contains all of the configuration files that I use on my main linux machines which run some version of Arch or Artix linux.

## Pictures

<div style="display: flex; flex-wrap: wrap; margin-right: -10px; margin-bottom: -10px;">
  <img width=300 src="https://i.imgur.com/YRxF52A.png" alt="Sakura">
  <img width=300 src="https://i.imgur.com/5G9znYr.png" alt="Village Night">
  <img width=300 src="https://i.imgur.com/dj1WJtK.png" alt="Desert Sunset">
  <img width=300 src="https://i.imgur.com/xI0Cqum.png" alt="Blue Reef">
  <img width=300 src="https://i.imgur.com/QcFoMaz.png" alt="Gruvbox">
  <img width=300 src="https://i.imgur.com/5RSdbGZ.png" alt="Purple Sunset">
</div>

## bspwm

The default window manager. Each monitor gets 9 independant workspaces.

### Keybinds

See [BSPWM Movement](#bspwm-movement).

## lf

lf is a terminal file manager.
The left column is the parent directory, the middle column is the current directory, and the right column is the contents of the selected file, or child directory.

Note: Icons are defined in `.zprofile`. if they don't work for you, simply comment out `set icons` in `~/.config/lf/lfrc`

### Keybinds

You move around with `h` `j` `k` `l`, or with the arrow keys.

- `ctrl + n` Create a new folder the in current dir.
- `ctrl + v` Create a new file in the current dir. & open it with the default text editor
- `shift + v` Open default editor (`nvim`) in current dir
- `g` goto top of directory listing
- `G` goto bottom of directory listing
- `c` Change name of a file/folder
- `a` Rename file/folder (beggining)
- `i` Rename file/folder (end)
- `D` Delete file/folder
- `d` cut file/folder
- `y` copy file/folder
- `p` paste file/folder
- `e` Encfs encrypt/decrypt secure directory (if it exists)

## nvim

A community rewrite of vim. The config file `.config/nvim/init.vim` is well documented if you want to see what features are included.

### Additions/Keybinds

fzf

- `ctrl + p` Fuzzy Find Git files in current project directory
- `ctrl + shift + p` Fuzzy Find any file in current project directory
  NERDTree
- `ctrl + n` toggle NERDTree (like the side menu in vscode)
  NERDCommenter
- `ctrl + /` to toggle commenting on:
  - in insert/normal mode: current line
  - in visual mode: selection
    Conquer of Completion
- `ctrl + <space>` autocomplete (if available through Conquer of Completion)
- `F2` rename every instance of a variable in the file
- `K` show documentation on currently selected item
  Git Gutter
  MarkDown Preview

### Themes

- sonokai
- alduin

## polybar

The default polybar is `default.ini` and is ran from `.xprofile`. By default it uses colors in Xresources.
The bar's workspace module is defined by the `WM` environment variable set in `zprofile` (all major env. variables are set in `zprofile` btw)
to make it easier to switch between i3 gaps and bspwm. Note that not all modules are enabled on by default,
if you want to change which modules are visible, look for the line with `modules-left` or `modules-right`
towards the top in the `[bar/default]` section.

### Modules

- wifi/ethernet (network module)
- volume
- cpu
- memory
- date
- i3/bspwm

## sxhkd

The simple x hotkey daemon. This is the program that handles all keyboard shortcuts on the system.
Note that it also handles all keyboard shortcuts for bspwm, since it does not come with any shortcuts by default

You can change all of these shortcuts at `~/.config/sxhkd/sxhkdrc`

### Keybinds

Note: the keybinds for bspwm are handled through sxhkd.
Note: `super` is the windows key.

#### Programs

- `super` + `q` close the focused window
- `super` + `shift` + `q` force close the focused window
- `super` + `d` run any script or program through dmenu
  - This is how you open programs that don't have direct keybinds
- `super` + `enter` opens a terminal
- `super` + `r` opens the file manager (lf)
- `super` + `w` opens the default web browser (firefox)
- `super` + `p` opens pulsemixer
  - This is how you change your audio settings
- `super` + `t` opens the torrent manager (tremc)
  - Only works when the VPN is on.

#### BSPWM Movement

- `super` + `h/j/k/l` to change the focused window
- `super` + `shift` + `h/j/k/l` to switch the position of the focused window
- `super` + `1-9` switch between workspaces
- `super` + `shift` + `1-9` moves the focused window to that workspace

#### BSPWM Window State

BSPWM offers different types of windows, here is how to switch between them.

- `super` + `alt` + `t` Tiled (default)
- `super` + `alt` + `f` Fullscreen
- `super` + `alt` + `s` Floating
- `super` + `shift` + `alt` + `t` Pseudo-Tiled

#### Other

- `super` + `+` Volume + 5
- `super` + `shift` + `+` Volume + 15
- `super` + `-` Volume - 5
- `super` + `shift` + `-` Volume - 15

- `super` + `alt` + `+` Screen brightness + 10%
- `super` + `alt` + `-` Screen brightness - 10%

- `super` + `PrintScreen` Take a screenshot
- `super` + `BackTick` Open emoji menu
- `super` + `shift` + `esc` Reload sxhkd

- `super` + `backspace` Shutdown Computer
- `super` + `alt` + `backspace` Reboot Computer

## sxiv

The simple x immage viewer.

#### Keybinds

- `n` next image (if any in current dir)
- `p` previous image (if any in current dir)

##### Custom Additions

The prefix to use any of these is `ctrl + x`

- `w` change the selected image to be your wallpaper

## zsh

The zoomer shell of course. Comes with syntax highlighting and a nice prompt.
**Prompt**
[powerlevel10k](https://github.com/romkatv/powerlevel10k),
**Plugins**

- [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)

### Keybinds

- `esc` or `caps lock` Go into vi mode

# Installation

[llGaetanll/autorice](https://github.com/llGaetanll/autorice) is the repo that will install these dotfiles on a fresh install of an arch based distribution.

# TODO

- [x] add docs and list of shortcuts (not entirely finished)
- [ ] add wiki page for each program
- [ ] add more pictures

## lf

- [ ] add `rsync`
- [x] add `encFS` keybinds
- [ ] add image previews
  - See: https://gitlab.com/Provessor/lfp

# Inspiration

- [lukesmithxyz/voidrice](https://github.com/lukesmithxyz/voidrice) for the base dotfiles (my dots are quite different to these now though)
- [lukesmithxyz/LARBS](https://github.com/lukesmithxyz/LARBS) for my auto-install script at [llGaetanll/autorice](https://github.com/llGaetanll/autorice)
