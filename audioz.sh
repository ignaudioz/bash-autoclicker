#!/bin/bash

min=0
max=0

# Colors they will look different in other system since its colorscheme based
RED=`tput setaf 2`
PURP=`tput setaf 5`
NC=`tput sgr0`
ORNG=`tput setaf 6`
# Default click
click=1

banner () {

  if [ ! -z $state ]; then clear; fi
  echo -e ' '${RED}'
                 .___.__              
_____   __ __  __| _/|__| ____________
\__  \ |  |  \/ __ | |  |/  _ \___   /
 / __ \|  |  / /_/ | |  (  <_> )    / 
(____  /____/\____ | |__|\____/_____ \
     \/           \/                \/
       '${NC}''
  echo -e "${RED} F4 to ${ORNG}start ${NC}|| ${RED}F6 to ${ORNG}stop ${NC}"
  if [ ! -z $state ]; then echo -e " ${RED}STATE:${ORNG} $state${NC}"; fi
}



bruh_momento () {
  clear
  banner
  echo -e "${RED}Enter the minecraft version you want to autoclick on:${NC}"
  read version
  title=`xdotool search --name $version`
  while [ -z $title ]
  do
    echo -e "${PURP}Minecraft version not found try again!"
    sleep 3
    clear
    echo -e "${RED}Enter the minecraft version you want to autoclick on:${NC}"
    read version
    title=`xdotool search --name $version`
  done
  echo -e "${RED}Left click or right click(l,r):"
  read tempclick
  echo -e "${RED}Enter the amount of cps you want(13,16,20):${NC}"
  read cps
  if [ $cps == 13 ]
  then
    min=95
    max=170
  elif [ $cps == 16 ]
  then
    min=65
    max=100
  elif [ $cps == 20 ]
  then
    min=45
    max=75
  else
    bruh_momento
  fi
}
if [ $tempclick == "r" ]; then click=3; fi
info_sex () {
  clear
  banner
  kok=bruh
  if [ $click == 3 ]; then kok="Right"; else kok="Left"; fi
  echo ${RED}Minecraft version ${NC}$version ${RED}found${NC}
  echo ${RED}Clicking on mouse ${NC}$kok
  echo ${RED}Amount of cps ${NC}$cps
}
# Starts asking questions
bruh_momento
# Info
info_sex

clicker () {
  while true
   do
     # Checks if the click u selected is on hold
     boi=`xinput --query-state 12 | grep -o 'button\['$click']=down'`
     # turns off
     sex1=`xinput --query-state 9 | grep -o 'key\[71]=down'`
     if [ ! -z $sex1 ] 
     then
       state="OFF"
       banner
       break
     fi
     while [ ! -z $boi ]
       do
         boi=`xinput --query-state 12 | grep -o 'button\['$click']=down'`
         delay=$((40+$min+$(shuf -i 0-$(($max-$min)) -n 1)))
         xdotool click --window $title --delay $delay $click
         sex1=`xinput --query-state 9 | grep -o 'key\[71]=down'`
         if [ ! -z $sex1 ] 
         then
           state="OFF"
           banner
           return 0
         fi
       done
  done
}

main_boi () {
  while true
  do
    # ALL OF THIS VALUES ARE PROBABLY DIFF ON UR KEYBOARD ! 
    # 70 equals F4, 71 equals F5,
    # turns on
    sex=`xinput --query-state 9 | grep -o 'key\[70]=down'`
    if [ ! -z $sex ] 
    then 
      state="ON"
      banner
      clicker
    fi
  done
}
# Starts this sex shit  
main_boi
