#!/bin/bash
# Darragh Tate, 2021
# Performs a system upgrade and removes old packages


# Colours for output text

# Used for 'warning' messages - Process starting, ending etc
red="\033[0;31m"

# Used for removal/cleaning functions
green="\033[0;32m"

# Used for updating/installing functions
blue="\033[0;36m"

# Used to reset text to white, so colours don't continue beyond where wanted
noColour="\033[0m"

# Strings for telling the user where they are in the upgrade process. Colour coded as above.
startingProcess="$red\n.............Update Process Starting Shortly - Press Ctrl + C to Cancel.............\n"
processCommencing="$red\n............................Update Process Starting Now............................." 
updating="$blue.......................................Update.......................................$noColour\n"
fullUpgrading="$blue\n....................................Full Upgrade....................................$noColour\n"
autoRemoving="$green\n.....................................Autoremove.....................................$noColour\n"
cleaning="$green\n.......................................Clean........................................$noColour\n"
autoCleaning="$green\n.....................................Autoclean......................................$noColour\n"
processComplete="$red\n..............................Update Process Complete...............................\n"

# Used in the timer() function. Is instantiated to be of a given length, and is reducted on each iteration to tell the user when the process will start
countdownString="$red."

# Generates a string of .'s, the length of which is the parameter passed ($1). Used for "counting down" to the process starting
generateString() {  
    for i in $(eval echo {1..$1})
    do
        fullStop="."
        countdownString=$countdownString$fullStop
    done
}

# Shows the countdownString of length($1) decreasing by 1 on each iteration, with a 0.7 second rest between
# Here to give the user time to cancel the update before it commences
timer () {

    # sets countdownString to be of length $1, the parameter passed
    generateString $1

    for i in $(eval echo {1..$1})
    do
        # CountdownString has the last character removed
        countdownString=${countdownString::-1}
        echo -e $countdownString
        # Wait 0.7 seconds before reiterating the loop
        sleep 0.7
    done

    # Display message to the user that the update process is starting
    echo -e $processCommencing

}

# Execute the update commands, with formatted output to the user as to where they are in the process
sudo -i echo -e $startingProcess && timer 5
echo -e $updating && sudo -i apt -y update 
echo -e $fullUpgrading && sudo apt -y full-upgrade 
echo -e $autoRemoving && sudo apt -y autoremove  
echo -e $cleaning && sudo apt-get clean
echo -e $autoCleaning && sudo apt autoclean
echo -e $processComplete