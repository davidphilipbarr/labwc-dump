LEAVE=$(zenity --question --default-cancel --text="Exit Labwc" --title="Logout")

if [ $? = 0 ]; then

killall dbus-daemon 
labwc -e

else
    exit
fi
