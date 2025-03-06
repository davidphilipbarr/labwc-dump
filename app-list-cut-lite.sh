#!/bin/bash
# Alternative Client-list menu based on lswt https://sr.ht/~leon_plickat/lswt/ 
# and wlctrl https://todo.sr.ht/~brocellous/wlrctl/7.
# it's incredibly hacky but for the most part seems to work. 
# [-] signifies minimised window [+] shoes the current active window
# Active,title,app-id,fullscreen,max,min
# lswt -c AtafmM
# org.gnome.Console,org.gnome.Ptyxis,foot,com.mitchellh.ghostty
exclude=("re.sonny.Retro")

wlist=$(lswt --force-protocol  zwlr-foreign-toplevel-management-unstable-v1 -c Atam | sed 's.\\,.※.g')
#tlist=$(lswt --force-protocol  zwlr-foreign-toplevel-management-unstable-v1 -c AtafmM | grep -E 'Console|foot|com.mitchellh.ghostty|Ptyxis' | sed 's.\\,.※.g')

echo '<openbox_pipe_menu id="window-list">'
  echo '<separator label="All Workspaces"/>'
# set the Internal Field Separator to newline

IFS=$'\n' 
for LINE in $wlist
do
vars(){
apptitle=$(echo "$LINE" | cut -d"," -f2 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g; s.※.,.g'  )
appid=$(echo "$LINE" | cut -d"," -f3 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
minimized=$(echo "$LINE" | cut -d"," -f4)
active=$(echo "$LINE" | cut -d"," -f1)


if [ "$minimized" = "true" ]
  then
        VIS="("
        VIS2=")"
	STATE="state:minimized"
  elif [ "$active" = "true" ] 
  then
	VIS="👁 "
  else 
	VIS=""
	  VIS2=""
   STATE="state:-active"
   fi
   }
   
# there issues with tilde
# rough match is better than none??  
  tildes(){ 
     if [[ "$apptitle" =~ "~" ]]
      then
      
      apptitle=$(echo "$apptitle"  | sed s/~/`printf '\176'`/g;  )
         echo "wlrctl window focus app_id:$appid "$STATE" "
      else
          echo "wlrctl window focus app_id:$appid "$STATE" title:"\""$apptitle"\"" "
	     
   fi
   }    
 vars
if  [[ !  ${exclude[@]} =~ $appid ]]
then   
   echo "<item label="\""${VIS}$appid  - ${apptitle}$VIS2"\""  icon="\""$appid"\"" >"
   echo "<action name="\""Execute"\""><execute>"
  tildes
   echo "</execute></action></item>"
 fi

done
echo "<separator />"
echo "<item class='wf' label='Move Workspace Left'  icon='/home/david/.config/waybar/go-previou.svg'>" 
echo '<action name="GoToDesktop" to="left" wrap="yes" />'
echo "</item>"
echo "<item label='Move Workspace Right' icon='/home/david/.config/waybar/go-next.svg'>"
echo '<action name="GoToDesktop" to="right" wrap="yes" />'
echo "</item>"
echo '</openbox_pipe_menu>'
