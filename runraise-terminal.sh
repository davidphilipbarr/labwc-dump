#!/bin/sh

if ! wlrctl window focus app_id:'org.gnome.Ptyxis' title:'david@huber: ~' ; then
    ptyxis  --new-window &
 
fi
