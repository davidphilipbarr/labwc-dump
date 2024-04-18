#!/bin/bash
 
obtheme=$(find $HOME/.local/share/themes/ -name 'themerc' | cut -d "/" -f7 | tr '\n' '|')
current=$(xmlstarlet select -t -v "//labwc_config/theme/name"  $HOME/.config/labwc/rc.xml)

newtheme=$(zenity --width=700  --forms --title "Labwc theme changer"  --text "\n Change Labwc theme with zenity and xmlstarlet,  try to find available theme from existence of themerc in $HOME/.local/share/themes.\n" --add-combo "Select Labwc theme" --combo-values "$current|$obtheme")
if  [ ! -z "$newtheme" ];
then 
xmlstarlet edit -L --update "//labwc_config/theme/name" --value "$newtheme" $HOME/.config/labwc/rc.xml &&

labwc --reconfigure
else 
echo "nothing to do"
fi


