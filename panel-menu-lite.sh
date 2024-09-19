#!/bin/bash
vpn=$(ip link show | grep tun0)
echo '<openbox_pipe_menu>'
    # CLOCK
TIME=$(date +%H:%M\ %B\ %d,\ %Y)


 echo "<item label='$TIME'>"
  echo '<action name="Execute"><execute>'
  echo "gnome-calendar"
  echo '</execute></action>'
  echo '</item>'
      # end CLOCK
  echo "   <separator/>"
  
  vol=$(echo "`wpctl get-volume @DEFAULT_SINK@ | sed 's/.* //'`" '* 100' | bc | sed 's/\..*/%/')
echo "<item label='Volume: $vol'>"
  echo '<action name="Execute"><execute>'
  echo "pavucontrol"
  echo '</execute></action>'
  echo '</item>'


 if [ -e "/home/david/.config/wayinhib" ]; then
  
  echo "<item label='Idle Inhibitor Active 💤'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/inhib-kill.sh"
  echo '</execute></action>'
  echo '</item>'

else 

 echo "<item label='Disable Auto Suspend'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/idle-inhib.sh"
  echo '</execute></action>'
  echo '</item>'

fi



if [ "$vpn" ]; 
then
vpnstatus="VPN Active"

echo "<item label='VPN Active &#128994;'>"
  echo '<action name="Execute"><execute>'
  echo "sudo killall openvpn"
  echo '</execute></action>'
  echo '</item>'

fi
    # END SHOW IF VPN is ACTIVE
    
# BATTERY STUFF
  key=$(upower -i /org/freedesktop/UPower/devices/keyboard_dev_CE_CE_51_7C_CE_53 | grep perc | cut -d ":" -f 2 | xargs)
echo "<item label='Keyboard battery: $key'>"
  echo '<action name="Execute"><execute>'
  echo "blueman-manager"
  echo '</execute></action>'
  echo '</item>'
  
  Battery=$(acpi -b | grep "Battery" | sed -nr '/Battery/s/.*(\<[[:digit:]]+%).*/\1/p')
echo "<item label=\"Battery: $Battery\"/>"

echo "   <separator/>"
  # END BATTERY STUFF
  
echo "<item label='Screenshot'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/.local/bin/grimshot.sh"
  echo '</execute></action>'
  echo '</item>'

echo "<item label='Colour Pick'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/waypick.sh"
  echo '</execute></action>'
  echo '</item>'
  
  
  
  
 echo "<item label='Change Background'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/.local/bin/waypaper"
  echo '</execute></action>'
  echo '</item>' 
echo "   <separator/>"
  echo "<menu id='bookmarks-menu' label='Bookmarks' execute='/home/david/bin/bookmarks.sh'/>"
  echo '<menu id="recent-menu" label="Recent" execute="/home/david/bin/recent-files.sh"/>'


# SETTINGS
echo '<menu id="settings" label="Settings">'


echo "<item label='Labwc Settings'>"
  echo '<action name="Execute"><execute>'
  echo "labwc-tweaks-gtk"
  echo '</execute></action>'
  echo '</item>'
  # VOLUME


echo "<item label='Volume Settings'>"
  echo '<action name="Execute"><execute>'
  echo "pavucontrol"
  echo '</execute></action>'
  echo '</item>'
    # END VOLUME
echo "<item label='Bluetooth Settings'>"
  echo '<action name="Execute"><execute>'
  echo "blueman-manager"
  echo '</execute></action>'
  echo '</item>'
 # END BLUETOOTH STUFF
 

# NETWORK STUFF  


echo "<item label='Network Manager'>"
  echo '<action name="Execute"><execute>'
  echo "nm-connection-editor"
  echo '</execute></action>'
  echo '</item>'
  echo '</menu> '
# END NETWORK STUFF  


echo '<menu id="power" label="Power">'
echo '  <item label="Log Out">'
 echo '<action name="Execute"><execute>'
  echo "/home/david/.local/bin/quitlabwc.sh"
  echo '</execute></action>'
  echo '</item>'



echo "<item label='Lock Screen'>"
  echo '<action name="Execute"><execute>'
  echo "wlopm --off"
  echo '</execute></action>'
  echo '</item>'
  
   echo '  <item label="Reconfigure">'
echo '    <action name="Reconfigure" />'
echo '  </item>'
  
  echo "<item label='Reset Audio'>"
  echo '<action name="Execute"><execute>'
  echo "sudo /home/david/bin/usbreset /dev/bus/usb/001/$( lsusb | grep QSB | cut -d " " -f4 | sed 's/://')"
  echo '</execute></action>'
  echo '</item>'
  
  
 echo '</menu> '
 


echo '</openbox_pipe_menu>'





