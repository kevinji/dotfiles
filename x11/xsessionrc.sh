#!/bin/bash

# Caps -> Esc/Ctrl
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'

# Swap LAlt/LWin
setxkbmap -option 'altwin:swap_lalt_lwin'
