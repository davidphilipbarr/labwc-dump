
cd  ~/.config/labwc

rm menu.xml

labwc-menu-generator > ~/.config/labwc/rootmenu.xml

echo "
" >> menu.xml
echo $(cat rootmenu.xml) >> menu.xml
echo "
" >> menu.xml
sed -i 's/<\/openbox_menu>//g' menu.xml

echo $(cat rightmenu.xml) >> menu.xml
echo "
" >> menu.xml
echo "</openbox_menu>" >> menu.xml

labwc --reconfigure 

