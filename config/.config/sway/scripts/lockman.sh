#!/bin/sh
# Times the screen off and puts it to background
background=$1
swayidle \
	    timeout 10 'swaymsg "output * dpms off"' \
	        resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
swaylock --image "$background"
# Kills last background task so idle timer doesn't keep running
kill %%
