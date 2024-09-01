
#!/bin/bash
#
# rover.sh - Rover Controls with Multiple Button Dialog

# Define GPIO pins for the motors
motorL=7
motorR=11

rc=1 # OK button return code =0 , all others =1
while [ $rc -eq 1 ]; do
  ans=$(zenity --info --title 'Drive a Rover' \
      --text 'Motor Action' \
      --ok-label Quit \
      --extra-button FORWARD \
      --extra-button STOP \
      --extra-button LEFT \
      --extra-button RIGHT \
       )
  rc=$?
  echo "${rc}-${ans}"
  echo $ans
  if [[ $ans = "FORWARD" ]]
  then
        echo "Running the Rover"
        gpio -1 write $motorL 1 ; gpio -1 write $motorR 1;
  elif [[ $ans = "STOP" ]]
  then
        echo "Stopping the Rover"
        gpio -1 write $motorL 0 ; gpio -1 write $motorR 0;
  elif [[ $ans = "LEFT" ]]
  then
        echo "Rover turning Left"
        gpio -1 write $motorL 1 ; gpio -1 write $motorR 0;
  elif [[ $ans = "RIGHT" ]]
  then
        echo "Rover turning RIGHT"
        gpio -1 write $motorL 0 ; gpio -1 write $motorR 1;
  fi
done
