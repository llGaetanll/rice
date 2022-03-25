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

Below is the list of programs that this repo has configurations for. Each program contains a list of custom documented keybindings.

## bspwm

The default window manager. This config should work on single or multi monitor setups. Each monitor gets 9 independant workspaces.

### Keybinds

See [BSPWM Movement](#bspwm-movement).

## lf

lf is a terminal file manager.
The left column is the parent directory, the middle column is the current directory, and the right column is the contents of the selected file, or child directory.

Note: Icons are defined in `.zprofile`. if they don't work for you, simply comment out `set icons` in `~/.config/lf/lfrc`

### Keybinds

#### Basics

You can move around with `h` `j` `k` `l`, or with the arrow keys.

- `g` Goto top of dir. listing.
- `G` Goto bottom of dir. listing.

- `space` Add/Remove file/folder from selection.
- `v` Invert selection in current dir.
- `u` Cancel selection.

- `D` Delete file/folder/selection.
- `y` Copy file/folder/selection.
- `d` Cut file/folder/selection.
- `p` Paste file/folde/selection.

- `c` Completely rename file/folder.
- `A` Rename file/folder (beggining).
- `I` Rename file/folder (end).
- `a` Rename file/folder (before extension).
- `i` Rename file/folder (after extension).

- `ctrl + n` Create a new folder the in current dir.
- `ctrl + v` Create a new file in the current dir. & open it with the default text editor.

#### Other

- `enter` Opens new terminal window in current dir.

- `ctrl + f` Fuzzy Find from current dir.
  - Needs `fzf` to be installed
- `shift + v` Open current dir. in default text editor (`nvim`)

- `~` Goes home.

- `e` Encfs encrypt/decrypt secure directory (if it exists).

- `x` Execute selected file.
- `X` Execute selected file in the background.

- `b` Set current file as wallpaper (must be an image).

For more info, see [lf tutorial](https://github.com/gokcehan/lf/wiki/Tutorial).

## tmux

The terminal multiplexer. The tmux theme should match the system theme. Mouse
mode is enabled. Vi mode is enabled.

### Keybinds

All the following keybinds are preceded by the leader: `ctrl + a`.

You can move between panes with `h` `j` `k` `l`.

- `ctrl + s` Toggle status bar.
- `ctrl + r` Reload config file.

- `n` Create new window.
- `q` Kill window.

- `s` Spawn new pane horizontally.
- `i` Spawn new pane vertically.
- `x` Kill pane.

- `ctrl` + `h`, `j`, `k`, or `l` Resize panes.
- `shift` + `j`, or `k` Move panes.

- `ctrl + a` Cycle panes.

## nvim

<img width=100% src="https://i.imgur.com/rZUMftx.png" alt="gruvbox-nvim">

A community rewrite of vim. The config file `.config/nvim/init.vim` is well documented if you want to see what features are included.

### Additions/Keybinds

- `,` The leader key.

#### Tabs

All Tab keybinds are prefixed by `<Tab>`.

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

- `ctrl + <space>` autocomplete (if available through Conquer of Completion).
- `F2` rename every instance of a variable in the file.

- `K` show documentation on currently selected item.
  - `ctrl + j/k` can be used to scroll up and down the window if possible.

#### Git Gutter

- `<Leader> + g + n` display next change.
- `<Leader> + g + p` display previous change.
- `<Leader> + g + z` toggle fold leaving only changes.

#### MarkDown Preview

- `<Leader> + m + p` toggles markdown preview in the default browser.

#### VimTeX

- `\ll` toggles compilation of current document
  - Opens in default pdf viewer
- `\le` close the quickfix window
- `\lt` display a table of contents
- `\lk` stops compilation
- `\lc` clears auxiliary files

### Themes

These can be changed in `~/.config/nvim/local.nvim`

- gruvbox (default)
- sonokai
- alduin

## polybar

Changing the polybar depends on your system. At startup in `~/.xprofile`, a
script named `polybar-start` (located at `~/.local/bin/polybar/polybar-start`)
is ran. In previous versions, this script would launch the polybar defined by
`$POLYBAR` on every visible display.

However to allow users to load different polybars on different screens, this
script is now symlinked by the user. It is recommended to define your
`polybar-start` scripts next to your polybars in `~/.config/polybar/`. By
default, the `polybar-start` is linked to the `single.sh` script which has the
same functionality as before.

### Linking a Custom Start Script

Back up the existing start script using

```
mv "$HOME/.local/bin/polybar/polybar-start" "$HOME/.local/bin/polybar/polybar-start.bak"
```

You can link a new script with the following command

```
ln -s "$HOME/.local/bin/polybar/polybar-start" "$XDG_CONFIG_HOME/polybar/<PATH>"
```

Where `<PATH>` is replaced by the relative path of your custom start script.

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

It is highly recommended you only install these dotfiles on a clean arch-based system using [llGaetanll/autorice](https://github.com/llGaetanll/autorice)
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

- [x] Add docs and list of shortcuts
- [ ] Add more pictures (never enough)
- [ ] Look for pywal alternatives.
  - pywal does not generate enough colors for nvim, which I rather would match system colors
    than a custom theme.
  - see: https://github.com/warpwm/lule

## nvim

- [ ] Sync open file with NERDTree
  - Current solution is commented out and does not work
  - I cannot get this to work, it is really hard for some reason
- [ ] Better git diff support
- Spell/Grammar check in comments/certain file formats
  - [ ] Latex
  - [ ] Markdown
  - [ ] Any programming language comments
- More syntax autocomplete
  - [ ] Latex autoclosing tags
  - [ ] Markdown
- [ ] Switch from CoC to Native LSP support?
  - This looks interesting, but looks like a lot of work.

## lf

- [ ] tmux integration
- [ ] Add `rsync` keybind
  - See: https://github.com/gokcehan/lf/issues/561
  - See: https://github.com/gokcehan/lf/wiki/Tips#show-progress-for-file-copying
- [x] Add `encFS` keybind
- [x] Add symlink keybind
- [ ] Add image previews
  - See: https://gitlab.com/Provessor/lfp
  - See: https://github.com/gokcehan/lf/wiki/Previews

## zathura

- [ ] Window currently spawns in floating mode

## polybar

- [ ] Add Mullvad VPN module
  - should prompt user for server through dmenu.
  - server list should be updatable from mullvad.net
- [ ] Add package update module
  - auto download packages through crontab every hour or so
  - format: `<pacman packages> <aur-packages>`
  - left click: refresh update count
  - right click: 1-click update

## bspwm

- [ ] Add keybind to switch highlighted window to the current workspace of a monitor
- [ ] Add keybind to fullscreen window across all monitors
- [ ] Hide all other windows behind a currently fullscreen window
  - Fullscreen transparent windows will show other windows behind it which doesn't look nice

## VimTeX

- [ ] Close vim if QuickFix is the only window left

# Inspiration

- [lukesmithxyz/voidrice](https://github.com/lukesmithxyz/voidrice) for the base dotfiles (my dots are quite different to these now though)
- [lukesmithxyz/LARBS](https://github.com/lukesmithxyz/LARBS) for my auto-install script at [llGaetanll/autorice](https://github.com/llGaetanll/autorice)
- [BrodieRobertson/dotfiles](https://github.com/BrodieRobertson/dotfiles) for more dotfile ideas

# See Also

- [llGaetanll/autorice](https://github.com/llGaetanll/autorice/)
  Installs these dotfiles as well as the required programs on any clean install of arch linux.

- [llGaetanll/suckess](https://github.com/llGaetanll/suckless/)
  Contains my suckless programs which this repo also uses.
