setmouse () {
	for id in $(xinput --list |grep 'Razer Razer Naga Hex .* pointer'|sed 's/.*id=\([0-9]*\).*/\1/')
	do
		#echo "setting device ID $id"
		xinput --set-prop $id 'Coordinate Transformation Matrix'	0.500000, 0.000000, 0.000000, 0.000000, 0.500000, 0.000000, 0.000000, 0.000000, 1.000000
		xinput --set-prop $id 'libinput Accel Profile Enabled' 0, 1
	done
}
#setmouse
xrdb -merge ~/.Xresources
exec i3
