#remap caps lock to a third control key. both shifts at once toggle shiftlock
setxkbmap -option ctrl:nocaps
#dark mode styling for qt and gtk apps.
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=adwaita-dark
# hidpi
#export GDK_SCALE=2
#export QT_AUTO_SCREEN_SCALE_FACTOR=1
xrdb -merge ~/.Xresources
i3
