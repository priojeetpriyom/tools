#!/bin/bash

# KYB_CH = channel on unifying receiver for the destination keyboard. Typically maps to the 1 minus the key # you press to switch keyboards
KEYBOARD_CH=0x01
# KYB_ID = ID of the keyboard (typically this maps to the order of keyboard devices you see in the unifying software app in Advanced settings)
KEYBOARD_ID=0x09

# MSE_CH = channel on unifying receiver for the destination mouse. Typically maps 1 minus the channel button you press on the mouse to switch
MOUSE_CH=0x01
# MSE_ID = ID of the mouse (typically this maps to the order of mouse devices you see in the unifying software app in Advanced settings)
MOUSE_ID=0x0A

# my mouse bluetooth receiver
RCVR_VID=046D
MOUSE_PID=B034
KEYBOARD_PID=B367


# MOUSE WORKING IN MAC MINI
#                                                                                       A     B    C          D         E       F --->
sudo /usr/local/bin/hidapitester --vidpid ${RCVR_VID}:${MOUSE_PID} --open --length 20 --send-output 0x11,0x00,${MOUSE_ID},0x1e,${MOUSE_CH},0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 --read-input

# KEYBOARD WORKING IN MAC MINI
#                                                                                           A     B        C        D        E         F --->
sudo /usr/local/bin/hidapitester --vidpid ${RCVR_VID}:${KEYBOARD_PID} --open --length 20 --send-output 0x11,0x00,${KEYBOARD_ID},0x1e,${KEYBOARD_CH},0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 --read-input

# Search showed that for Bluetooth devices we need to send a load of 20 bytes
# A: Header
# B: Device ID, for Bluetooth is 0 as each device connects independently
# C: ID
# D: Constant
# E: Destination Channel from 0 to 2 (buttons 1 to 3)
# F: Filling

exit 0

# STEPS

# 1. Copy hidapitester to /usr/local/bin/
# 2. Copy log-switch.sh to /usr/local/bin/
# 3. Make the script executable: chmod +x /usr/local/bin/log-switch.sh
# 4. make hidapitester executable: chmod +x /usr/local/bin/hidapitester
# 5. Add following line to the end of: sudo visudo
# ${USER} ALL=(ALL) NOPASSWD: /usr/local/bin/hidapitester
# 6. Create App with Automator
# SAVE THE app as LogiSwitch.app under /Applications/
# Open Logitech Options+ and assign shortcut to open the app

# https://github.com/marcelhoffs/input-switcher/blob/master/mac/switch.sh
