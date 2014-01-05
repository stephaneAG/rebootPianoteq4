#rebootPianoteq4
Mac OS X .App / bash script to handle tedious tasks ..


### Goal
Simple script that aims to contain the process produced by Automator ( wich is executed while still residing in its initial "dedicated .App" )

===============
### Usage

It 's intended to be run from the command line, else one can prefer to use the .App, docked or not, for easy access.

Note that either way, once it's running, the "watching process", while in use, displays a rotating cogwheel in Mac OS X top ( status ?) bar.
If the user wants to stop it, he can either right click the icon in the dock or click the cogwheel icon in the top OS bar BUT! -> line right below ;)
If the "watching process" was launched using the current bash script and thus from the command line, it is appropriate to just "Ctrl-C" the script & let it handle that by itself.

-> If for any reason, it couldn't stop the "watching process" as well as closing itself when hitting "Ctrl-C",
   the "watching process" can still be stopped by either right clicking the icon in the dock or clicking the rotating cogwheel icon in the top OS bar,
   as it's done while using the .App to launch rebootPianoteq4.

===============
### About Pianoteq

Pianoteq is a great piece of software: its a standalone app / VST that can provide different piano configurations using effiscient algorithms instead of sample.
Thing is, there is no "fully free version" for specific usage & I can't afford it right now, so I guessed I was still gonna learn code & piano with "missing keys" ( R: it WORKS -> we perceive with our ears, we hear with our mind ;p )

Thus, the "easy and fair ( for the dev team behind it )" way I found was to "dodge" some of the tedious stuff needed while using the "Trial" version of the standalone app:

  aka "close -> relaunch -> close trial dialog -> engage sustain pedal"
  
I am currently digging if there's a way to skip the entire process using the VST plugin version, or even re-enable the missing keys, but I'd truly prefer being able to buy a copy of that stuff :).
