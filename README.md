all of my dotfiles, managed with (https://www.gnu.org/software/stow/manual/stow.html)[stow]

## Dependencies:
This does not list the package manager dependencies of the programs the dotfiles are for, but any extra dependencies that are needed for the specific configuration.

### Whole-repo
GNU stow is used to manage individual dotfiles 'packages'.

### Aalacritty
setup to use Hack Nerd Font (`ttf-hack-nerd`) for an icon-rich font, needed for the full nvim and for yazi. Can easily be changed to any other nerd-font patched font.

### Kitty
you dont need a patched Nerd Font, normal `ttf-fira-code` combined with `ttf-nerd-fonts-symbols` will do. Can also change what font is used easily, but always needs the nerd-font symbols.

### Yazi
Will need https://github.com/jstkdng/ueberzugpp installed if using on alacritty, availible in AUR (only needed for image previews).
also has optional dependencies on jq, unarchiver, ffmpegthumbnailer, fd, ripgrep, fzf, and poppler

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

### Zsh

* nvim ($EDITOR and $VISUAL is set to this)
* less
* fzf

Software used by aliases:
* nvim
* neomutt
* sudo
* latexmk
* feh
* libreoffice (for word to pdf conversions)
* sshfs

### Paru
uses yazi as a file explorer

### Yazi
for accurate mimetype info, I suggest installing `perl-file-mimeinfo`

### Khal and Khard:
both require the vdirsyncer program and config.

### vdirsyncer
Dont use the config unmodified, as it currently points to my server, you will need to replace the relevant urls and usernames. Also, you will need pass installed and with your password set on your nextcloud domain.
