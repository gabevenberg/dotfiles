all of my dotfiles and text only plugins. (the few I have at the moment...)

## Dependencies:
This does not list the package manager dependencies of the programs the dotfiles are for, but any extra dependencies that are needed for the specific configuration.

### Whole-repo

GNU stow is used to manage individual dotfiles 'packages'.

### Aalacritty
setup to use Hack Nerd Font for an icon-rich font, needed for the full nvim

### Latexmk
Uses zathura as a pdf previewer.

### Mpd
Setup to output audio through pipewire

### I3wm
These are all the programs that i3 calls somewhere in its config, whether that be keybinds, startup applications, etc.

* alacritty
* cool retro term
* i3-lock
* brightnessctl
* xdotool
* maim (screenshot program)
* xcolour (colour picker)
* mpc (mpd stuff, remove relevant keybinds if you dont use mpd)
* pavucontrol
* geoclue (geolocation dameon)
* feh (for setting desktop wallpaper)
* dunst
* i3status
* gnome-keyring (for login management in, for example, nextcloud. See https://gabevenberg.com/posts/autologinnextcloudclientonarch/ for details.)
* geoclue (for geolocation)

### x11 and x11hidpi
these are mutually exclusive directories, one is for hi-dpi screens. They have the same requirements otherwise.
These .xinitrc's are setup to launch i3, with the config package in this repo.

### Neovim

If you want a neovim config that does not reqire external dependencies, install the nvim_minimal config.

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
* xsel if using x
* waycopy and waypaste, or wl-copy and wl-paste, if using wayland (untested)

For telescope:
* ripgrep
* fd

### Zsh

* nvim ($EDITOR and $VISUAL is set to this)
* less
* fzf

software used by aliases:
* nvim
* neomutt
* sudo
* latexmk
* feh
* libreoffice (for word to pdf conversions)
* sshfs

### Paru
currently uses vifm, but I really need to change that

### Vifm
* zathura
* poppler
* w3m

### Khal and Khard:
both require the vdirsyncer program and config.

### vdirsyncer
Dont use the config unmodified, as it currently points to my server, you will need to replace the relevant urls and usernames. Also, you will need pass installed and with your password set on your nextcloud domain.