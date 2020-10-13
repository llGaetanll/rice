# Rice
I got some of this from [lukesmithxyz/voidrice](https://github.com/lukesmithxyz/voidrice)

## Pictures
<div style="display: flex; flex-wrap: wrap; margin-right: -10px; margin-bottom: -10px;">
  <img width=300 src="https://i.imgur.com/YRxF52A.png" alt="Sakura">
  <img width=300 src="https://i.imgur.com/5G9znYr.png" alt="Village Night">
  <img width=300 src="https://i.imgur.com/dj1WJtK.png" alt="Desert Sunset">
</div>

  


## What's included
### bspwm
The default window manager. Each monitor gets 9 independant workspaces.
#### Keybinds
- `super + q` close the focused window
Move pane focus around with `h` `j` `k` `l`.
- Holding `shift` moves the selected pane in that direction.

Move to a work space with `super`(windows key) + `<workspace-number>` (1-9 by default)
- Holding `shift` moves the selected pane to that workspace.

### i3 (i3gaps)
No longer my main window manager, but it works perfectly fine.
#### Keybinds
- `super + q` close the focused window
Move panes around with `h` `j` `k` `l`.
- Holding `ctrl` resizes them in that direction
- Holding `shift` moves them in that direction.

### lf
The file manager. Comes with icons defined in `.zprofile`
#### Keybinds
You move around with `h` `j` `k` `l`. I think the arrow keys work too
- `ctrl + n` New folder in current dir.
- `ctrl + v` Open default editor (`nvim`) in current dir
- `c` Rename file
- `D` Delete file/folder
- `y` Yank (copy) file/folder
### nvim
Better vim. By far my biggest config file since I use it all the time. I cant even begin to explain all the keybinds for it here but look at the config file it's well documented
#### Additions/Keybinds
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
#### Themes
- sonokai
- alduin

### polybar
The default polybar is `default.ini` and is ran from `.xprofile`. By default it uses colors in Xresources. The bar's workspace module is defined by the `WM` environment variable set in `zprofile` (all major env. variables are set in `zprofile` btw) to make it easier to switch between i3 gaps and bspwm. Note that not all modules are enabled on by default, if you want to change which modules are visible, look for the line with `modules-left` or `modules-right` towards the top in the `[bar/default]` section.
#### Modules
- wifi/ethernet (network module)
- volume
- cpu
- memory
- date
- i3/bspwm

### sxhkd
The simple x hotkey daemon. This is the program that contains the keyboard shortcuts to all my main programs (as well as the ones for bspwm since it doesn't have its own hotkey event detector).
#### Keybinds
Note that `super` is the windows key
##### Programs
- `super + enter` opens the main terminal (st)
- `super + w` opens the main web browser (firefox)
- `super + r` opens the file manager (lf)
- `super + p` opens the volume/sound manager (pulsemixer)
- `super + t` opens my torrent setup (tremc and transmission-cli)
- `super + d` dmenu - this is how you run a program that doesn't have its own keybind
##### Other
- `super + backspace` shutdown computer
- `super + shift + backspace` reboot computer
- `super + equals` volume + 5
- `super + minus` volume - 5
- `super + shift + equals` volume + 15
- `super + shift + minus` volume - 15

### sxiv
The simple x immage viewer.
#### Keybinds
- `n` next image (if any in current dir)
- `p` previous image (if any in current dir)
##### Custom Additions
The prefix to use any of these is `ctrl + x`
- `w` change the selected image to be your wallpaper

### zsh
The zoomer shell of course. Comes with syntax highlighting and a nice prompt.
**Prompt**
  [powerlevel10k](https://github.com/romkatv/powerlevel10k), 
**Plugins**
  - [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
  
#### Keybinds
- `alt + z` Go into vi mode


## TODO
- [X] add docs and list of shortcuts (not entirely finished)
- [ ] add more pictures
### lf
- [ ] add more quality-of-life keybinds for file renaming
- [ ] incorporate `rsync` and `encFS` keybinds
- [ ] add image previews pleaaaasse bro
### tmux
- [ ] make it look nice & make it use colors from Xresources
### neofetch
- ~~add random pic from folder~~ st image support is pretty mid
