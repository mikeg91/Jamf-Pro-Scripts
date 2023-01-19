#!/bin/sh

# Defines file to look for, you will want to make this a file in a place you know
file="/Library/Company IT/FirstRunComplete.txt"

# checks if file is on location specified above echos First Run has not happened and runs trigger to install or echos it's installed
if [ ! -f "$file" ]; then
	echo First Run has not happened running FirstRun Policy
        
    # Gives 2 minutes for things to complete during setup
    sleep 120

    # Installs Rosetta 2 on Apple Silicon Macs
    jamf policy -event Rosetta2

    # Installs some policy
    jamf policy -event 

    # Updates computer inventory 
    jamf recon

    # Resets login window to macOS if using Jamf Connect
    # authchanger -reset

    # Creates FirstRunComplete file to stop re-run 
    touch /Library/Company\ IT/FirstRunComplete.txt

else
    echo FirstRun has already happened. Exiting.
fi
