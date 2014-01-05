#!/bin/bash

# stag_rebootPianoteq4

# Simple script that aims to contain the process produced by Automator ( wich is executed while still residing in its initial "dedicated .App" )
# It 's intended to be run from the command line, else one can prefer to use the .App, docked or not, for easy access.
#
# Note that either way, once it's running, the "watching process", while in use, displays a rotating cogwheel in Mac OS X top ( status ?) bar.
# If the user wants to stop it, he can either right click the icon in the dock or click the cogwheel icon in the top OS bar BUT! -> line right below ;)
# If the "watching process" was launched using the current bash script and thus from the command line, it is appropriate to just "Ctrl-C" the script & let it handle that by itself.
#
# -> If for any reason, it couldn't stop the "watching process" as well as closing itself when hitting "Ctrl-C",
#    the "watching process" can still be stopped by either right clicking the icon in the dock or clicking the rotating cogwheel icon in the top OS bar,
#    as it's done while using the .App to launch rebootPianoteq4.
#
# by StephaneAG - 2014

## --

# littl' set of color helpers - 'll be notably used when "sourcing" the colored logo file
pink_color="\033[1;35m"
red_color="\033[31m"
lightblue_color="\033[1;36m"
blue_color="\033[1;34m"
normal_color="\033[0m"

## --

# - a fcn to display an animation if we want to do so ( yup, I may add an optional parameter to specify with or without .. for the fun or learning .. "and the joy of tinkering !" ;D
# 1st version - nice, but a littl' bit too fast .. and I'd like some more "elements" ;)
display_animation(){
  # originally: for a in \\ \| \/ -; do
  #for a in '.||' '|.|' '||.' '|.|'; do # 1st version - nice but fast ( and a tiny ! ) -- actually, I prefer the 1st one, wich seems more like a 'tiny-equaliser gone crazy' ;D
  #for a in '|..' '.|.' '..|' '.|.'; do # 1st version - alternate
  #helper> 1         2         3         4         5         6         7         8(6)      9(5)      10(4)     11(3)     12(2)
  for a in '.||||||' '|.|||||' '||.||||' '|||.|||' '||||.||' '|||||.|' '||||||.' '|||||.|' '||||.||' '|||.|||' '||.||||' '|.|||||'; do
    echo -e -n '\033[1;36m'
    echo -n $a; # originally ' echo -n $a; '
        echo -e -n '\033[0m'
    sleep 0.01;
        echo -n -e \\r;
  done
}

## --

# we trap any user interruption of the script ( aka "Ctrl-C" )
trap ctrl_c INT

# we create a var to hold the PID of the watching process to be later to stop it if the user hits "Ctrl-C"
WATCHER_PID=0 # init to 0 ( as it's unlikely that the "watching process" will get that as a PID )

# function to be run when the user "Ctrl-C"s ( aka "cleanup function" )
function ctrl_c(){
  printf "\r\n\r\n" # R: we're on Mac -> \r\n
  #echo "**Trapped CTRL-C"
  #printf "\r\n\r\n"
  
  if [ $WATCHER_PID -eq 0 ]
  then
    echo "PID of watching process was not set correctly"
  else
    # we "gently kill" the process by sending it a "SIGTERM"
    echo "Stopping watching process .."
    kill -s SIGTERM $WATCHER_PID
    echo "Watching process was stopped correctly."
  fi
  
  printf "\r\n"
  echo "Quitting stag_rebootPianoteq4 ..."
  exit 0
}

# rest of the program
printf "\r\n"

# a little logo ( one will be created specially for the script later ;D )
source logo_colored # we "source" the file where the logo resides in

#echo ""
echo -e "$lightblue_color stag_rebootPianoteq4 cli v0.1 $normal_color"
printf "\r\n"
echo "Pianoteq 4 will now be exited once, and rebooted every 19 minutes after being relaunched for the first time."
echo "As a bonus, the trial message will be automatically closed and the sustain pedal will be engaged ;p"
echo "While the watching process responsible for the reboot of the Panoteq4 App is running, an informative rotating cogwhell is displayed at the top of the OS status bar."

printf "\r\n"
echo "Launching watching process .."

# actual program stuff ( here, we launch a unix process resulting from an "Automator" workflow saved as a .App & extracted from that .App, & captures its PID )

## -- 

  # we launch the "watching process in the background"
  #/bin/bash dummyCounter.sh & # != than "sourcing" (  aka ". thescript.sh" or " source thescript.sh " -> see what's done for the colored logo ( yup, we're passing variables ;p ) )
  ./stag_rebootPianoteq4.app/Contents/MacOS/Application\ Stub >/dev/null 2>&1 &
  
  # we get the PID of the last command executed
  #echo "PID of watching process fetched is: $!" # we echo it to stdput to see it ( wip )
  
  # we "gently kill" the process by sneding it a "SIGTERM"
  #kill -s SIGTERM $!
  WATCHER_PID=$!
  #echo "PID of watching process set to: $WATCHER_PID"
  
  # inform the user that the watching process has been started and can be quitted by pressing "Ctrl-C"
  echo "Watching process is now running .."
  printf "\r\n"
  echo -e "Hit $red_color\"Ctrl-C\"$normal_color to stop the watching process & quit stag_rebootPianoteq4"
  
  
  
  # littl' trick to maintain our script running while actually "doing nothing" except waiting for an eventual "Ctrl-C" from the user
  #tail -f /dev/null # works, but I am now 'musing with the 'display_animation' fcn
  
  # thnk about "modding" the following like:
  # . .. ... <erase all> . .. ... (etc..)
  # or
  # ".  " -> " . " -> "  ." -> " . " -> ".  " -> (etc..)
  
  # the 'display_animation' in action ! ;)
  for (( ; ; ))
  do
    display_animation # display the animation before looping over it again .. and again ..
    #sleep 1 # sleep 1 second before .. sleeping one second again ..
  done
  
  # other way of doing an endless ( infinite @ useless ) loop, less elegant
  #for (( ; ; ))
  #do
  #  sleep 1 # sleep 1 second before .. sleeping one second again ..
  #done
  
  
## --