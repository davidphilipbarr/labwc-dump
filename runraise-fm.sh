#!/bin/sh

if ! wlrctl window focus app_id:'org.gnome.Nautilus' title:'Home' ; then
    nautilus  -w &
 
fi
