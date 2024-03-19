all of my dotfiles, managed with (https://www.gnu.org/software/stow/manual/stow.html)[stow]

## Nix

I am working on migrating my dotfiles to nix, to allow configuration and installation in a single step.
In order to use the nix setup, you need to install nix and enable flakes,
then run `nix run --extra-experimental-features "nix-command flakes" --no-write-lock-file github:nix-community/home-manager/ -- --extra-experimental-features "nix-command flakes" --flake . switch`, while in the nix directory.
from then on, you can update your configuration after making a change with `home-manager --flake . switch`.
Alternatively, if you have `just` installed, you can use `just boostrap` and `just switch`, instead.

## Dependencies:
This does not list the package manager dependencies of the programs the dotfiles are for, but any extra dependencies that are needed for the specific configuration.

### Whole-repo
GNU stow is used to manage individual dotfiles 'packages'.

### Aalacritty
uses `hack` for a font, dont need a patched nerd font, normal `ttf-hack` (or any other font) combined with `ttf-nerd-fonts-symbols` will do.

### Kitty
you dont need a patched Nerd Font, normal `ttf-fira-code` combined with `ttf-nerd-fonts-symbols` will do. Can also change what font is used easily, but always needs the nerd-font symbols.

### Yazi
Will need https://github.com/jstkdng/ueberzugpp installed if using on alacritty, availible in AUR (only needed for image previews).
also has optional dependencies on jq, unarchiver, ffmpegthumbnailer, fd, ripgrep, fzf, zoxide, and poppler

### Latexmk
Uses zathura as a pdf previewer.

### Mpd
Setup to output audio through pipewire

### I3wm
These are all the programs that i3 calls somewhere in its config, whether that be keybinds, startup applications, etc.

* alacritty or kitty (currently uses kitty, just comment out one line or the other in the i3 conf to switch)
* cool retro term
* i3-lock
* brightnessctl
* xdotool
* maim (screenshot program)
* xcolor (color picker)
* mpc (mpd stuff, remove relevant keybinds if you dont use mpd)
* pavucontrol
* geoclue (geolocation dameon)
* feh (for setting desktop wallpaper)
* dunst
* i3status
* xclip
* gnome-keyring (for login management in, for example, nextcloud. See https://gabevenberg.com/posts/autologinnextcloudclientonarch/ for details.)

### x11 and x11hidpi
These are mutually exclusive directories, one is for hi-dpi screens. They have the same requirements otherwise.
These .xinitrc's are setup to launch i3, with the config package in this repo.

### xorg_conf
Dont stow this directory, but place the files you want (each one has comments describing its purpose) into `/etc/X11/xorg.conf.d/`.

### Neovim

If you want a neovim config that does not require external dependencies, install the nvim_minimal config.

For the status line, and other icons:
any nerd font patched font, and your terminal setup to use it. (the included alacritty config is set up for it)

For packer:
* git

For Mason.nvim:
* unzip
* wget
* curl
* gzip
* tar
* bash
* python
* node and npm
* cargo
* pip

For treesitter:
* gcc
* git
* node

For neovim clipboard:
* xclip if using x
* waycopy and waypaste, or wl-copy and wl-paste, if using wayland (untested)

For telescope:
* ripgrep
* fd

### Fish, zsh, and nushell

* nvim ($EDITOR and $VISUAL is set to this)
* less
* fzf
* optional: zoxide (nicer cd)
* optional: starship (nice prompt)

Software used by aliases:
* nvim
* sudo
* latexmk
* espeak-ng
* tre
* feh
* libreoffice (for word to pdf conversions)
* sshfs

### nushell

Nushell currently also needs fish installed for comlpletions.

### Paru
uses yazi as a file explorer

### Yazi
for accurate mimetype info, I suggest installing `perl-file-mimeinfo`

### Git
For diff tools, install `git-delta` and `difftastic`. I also reccomend installing `lazygit` and/or `tig`

### Khal and Khard:
both require the vdirsyncer program and config.

### vdirsyncer
Dont use the config unmodified, as it currently points to my server, you will
need to replace the relevant urls and usernames. Also, you will need pass
installed and with your password set on your nextcloud domain.

### starship
starship is a program for a very nice CLI promt, including a ton of info about
the current git repo. Optional for zsh and fish, mandatory for nushell.
