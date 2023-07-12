#remap caps lock to a third control key. both shifts at once toggle shiftlock
setxkbmap -option ctrl:nocaps
#dark mode styling for qt and gtk apps.
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=adwaita-dark
xrdb -merge ~/.Xresources
#get gnome-keyring running
dbus-update-activation-environment --all
gnome-keyring-daemon --start --components=secrets
i3
