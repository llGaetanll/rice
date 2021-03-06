# Rice

This repo contains all of the configuration files that I use on my main linux machines which run some version of Arch or Artix linux.

# Pictures

<div style="display: flex; flex-wrap: wrap; margin-right: -10px; margin-bottom: -10px;">
  <img width=33% src="https://i.imgur.com/YRxF52A.png" alt="Sakura">
  <img width=33% src="https://i.imgur.com/5G9znYr.png" alt="Village Night">
  <img width=33% src="https://i.imgur.com/dj1WJtK.png" alt="Desert Sunset">
  <img width=33% src="https://i.imgur.com/xI0Cqum.png" alt="Blue Reef">
  <img width=33% src="https://i.imgur.com/QcFoMaz.png" alt="Gruvbox">
  <img width=33% src="https://i.imgur.com/5RSdbGZ.png" alt="Purple Sunset">
</div>

# Programs

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

<img width=100% src="https://i.imgur.com/rZUMftx.png" alt="gruvbox-nvim">

A community rewrite of vim. The config file `.config/nvim/init.vim` is well documented if you want to see what features are included.

### Additions/Keybinds

#### Tabs

All Tab keybinds are prefixed by `<Tab>` (obviously).

- `<Tab> + n` move to next tab. Same as `gt`
- `<Tab> + N` move to previous tab. Same as `gT`
- `<Tab> + t` move current window to a new tab.
- `<Tab> + a` create a new tab with an empty window.
- `<Tab> + h` move current tab left.
- `<Tab> + l` move current tab right.

#### Windows

- `ctrl + w + ctrl + h/j/k/l` resize current window.

#### fzf

- `ctrl + p` Fuzzy Find Git files in current project directory
- `ctrl + shift + p` Fuzzy Find any file in current project directory

#### NERDTree

In this config, NERDTree also comes with file icons, git icons, and syntax highlighting.

- `ctrl + n` toggle NERDTree (like the side menu in vscode)

#### NERDCommenter

- `ctrl + /` toggle commenting. works in `normal`, `insert`, and `visual` mode.

#### Conquer of Completion

- `ctrl + <space>` autocomplete (if available through Conquer of Completion)
- `F2` rename every instance of a variable in the file

- `K` show documentation on currently selected item.
  - `ctrl + j/k` can be used to scroll up and down the window if possible.

#### Git Gutter

- `<Leader> + g + n` display next change.
- `<Leader> + g + p` display previous change.
- `<Leader> + g + z` fold all code leaving only changes.

#### MarkDown Preview

- `<Leader> + m + p` toggles markdown preview.

### Themes

- gruvbox (default)
- sonokai
- alduin

## polybar

Changing the polybar depends on your system. At startup in `~/.xprofile`, a script named `polybar-start`
is ran. In previous versions, this script would launch the polybar defined by `$POLYBAR` on every visible
display.

However to allow users to load different polybars on different screens, this
script can now be symlinked by the user. It is recommended to define your
start scripts next to your polybars in `~/.config/polybar/`. By default, the
`single.sh` script is linked to `polybar-start` which has the same functionality
as before.

### Modules

- wifi/ethernet (network module)
- volume
- cpu
- memory
- date
- bspwm

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

The simple x image viewer.

#### Keybinds

- `n` next image (if any in current dir)
- `p` previous image (if any in current dir)

##### Custom Additions

The prefix to use these commands is `ctrl + x`

- `w` change the selected image to be your wallpaper
- `c` copy the file to a given directory
- `m` move the file to a given directory
- `r` rotate the image 90 degrees clockwise and save
- `R` rotate the image 90 degrees counterclockwise and save
- `f` flips image across the y axis
- `y` copies file name to clipboard
- `Y` copies full path to clipboard
- `d` delete the file
- `g` open the file in Gimp
  - note that Gimp is not installed by default so you will need to install it to be able to
    use this

## zsh

The zoomer shell of course. Comes with syntax highlighting and a nice prompt.
**Prompt**
[powerlevel10k](https://github.com/romkatv/powerlevel10k),
**Plugins**

- [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)

### Keybinds

- `esc` or `caps lock` Go into vi mode

# Installation

It is highly recommended you install these dotfiles on a clean arch-based system using [llGaetanll/autorice](https://github.com/llGaetanll/autorice)
since the script performs some automatic post installation cleanups not covered by this repo.

I have successfully installed these dotfiles on both Arch and Artix.

# Post-Installation

## Changing the Wallpaper

- **With lf**
  1. Navigate to the picture of your choice
  2. Press `b`
- **With sxiv**
  1. Go to the picture of your choice
  2. Press `ctrl` + `x` followed by `w`

This triggers the `setbg` script which changes the file at `~/.local/share/bg`.

## Changing the Polybar

All system-dependent environment variables are placed in `~/.config/xinitrc`. Change the
`$POLYBAR` variable to the path of the bar you want to use.

Different polybars are available in `~/.config/polybar`.

Note that you may need to install any required fonts by the polybar. Such fonts are listed
in the bar's `ini` file and can be downloaded directly from the AUR.

Finally to apply the changes simply restart bspwm using the following command

```
killall bspwm
```

## Bringing back Caps Lock

In this system, I remapped caps lock to escape. This is to help me work in vim more easily
but I can understand how this may turn off some people. To bring back caps lock simply
comment out or delete the following line in `.xprofile`.

```ini
# remap caps lock to escape. I absolutely need this to survive in vim
setxkbmap -option caps:escape
```

## Reverse Scrolling Direction

If you're installing this on a laptop, there's a chance you might want to reverse the scrolling direction like me.
[This blog post](https://n00bsys0p.wordpress.com/2011/07/26/reverse-xorg-scrolling-in-linux-natural-scrolling/) describes how to do this very well.

In my case, swapping `4` and `5` reversed vertical scrolling, and switching `6` and `7` reversed horizontal scrolling.

If like me you got multiple slave pointer devices, simply try switching these numbers around on each of them, and undo your changes if you don't notice
a difference in scrolling direction.

# TODO

- [x] add docs and list of shortcuts
- [ ] add more pictures
- [ ] Look for pywal alternatives.
- pywal does not generate enough colors for nvim, which I rather would match system colors
  than a custom theme.

## lf

- [ ] Add `rsync` keybind
  - See: https://github.com/gokcehan/lf/issues/561
- [x] Add `encFS` keybind
- [ ] add image previews
  - See: https://gitlab.com/Provessor/lfp

# Inspiration

- [lukesmithxyz/voidrice](https://github.com/lukesmithxyz/voidrice) for the base dotfiles (my dots are quite different to these now though)
- [lukesmithxyz/LARBS](https://github.com/lukesmithxyz/LARBS) for my auto-install script at [llGaetanll/autorice](https://github.com/llGaetanll/autorice)
