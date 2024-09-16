#!/bin/sh
#
#########################
# Created by mikeg91
#
# A Jamf helper script with many setting passed to Jamf Parameters.
# Paremeter 4 - Main body text  use \n\n for a new line
# Paremeter 5 - Button 1 Text Box (put OK in it if nothing else
# Paremeter 6 - Buton 2 text box (put cancel in there if nothing else)
# Paremeter 7 - Button 1 action (can send jamf policies)
# Paremeter 8 - Button 2 action (can send jamf policies)
#
##### History #####
#
# v1.0 Sept 16 2024 - mikeg91
# Created script 
#
##############

JAMFHELPER="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
YOURicon="/Library/Application Support/COMPANY-IT/COMPANY-Logo.png"
Desc="$4"
MSG=$( printf "$Desc" )

# Get the user's selection
RESULT=`"$JAMFHELPER" -windowType utility -icon "$CRAicon" -title "COMPANY NAME IT" -description "$MSG" -button1 "$5" -button2 "$6"`

if [ $RESULT == 0 ]; then
    "$7"
    echo "Button 1 was pressed!"
elif [ $RESULT == 2 ]; then
    "$8"
    echo "Button 2 was pressed!"
fi
