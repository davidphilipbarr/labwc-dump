#!/bin/bash

$(ps -ef | grep "wayland-idle-inhibitor.py" | awk '{print $2}' | xargs sudo kill) 
rm /home/david/.config/wayinhib
