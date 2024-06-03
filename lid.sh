lid=$(cat /proc/acpi/button/lid/LID/state | grep closed)

if [[ $lid =~ "closed" ]]
then
wlr-randr --output eDP-1 --off &
else
wlr-randr --output eDP-1 --on &
fi



