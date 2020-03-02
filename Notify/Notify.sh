#!/bin/bash

#variables
NOTIFY_LOG="/var/tmp/depnotify.log"
TOKEN_BASIC="/var/tmp/idtokenbasic"
TOKEN_RAW="/var/tmp/idtokenraw"
GIVEN_NAME=Archie
TOKEN_GIVEN_NAME=$(echo "$(cat $TOKEN_BASIC)" | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep given_name)
TOKEN_UPN=$(echo "$(cat $TOKEN_BASIC)" | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep upn)
JAMF_BINARY="/usr/local/bin/jamf"

echo "STARTING RUN" >> $NOTIFY_LOG

# Define the number of increments for the progress bar

echo "Command: Determinate: 10" >> $NOTIFY_LOG

#1 - Introduction window with username and animation

echo "Command: Image: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbookpro-15-retina-touchid-space-gray.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Welcome to Invitae!" >> $NOTIFY_LOG
echo "Command: MainText: Your Mac is now managed and will be automatically configured for you. \n $TOKEN_GIVEN_NAME" >> $NOTIFY_LOG
echo "Status: Preparing your new Mac..." >> $NOTIFY_LOG
sleep 10



#2 - Everything you need for your first day

echo "Command: Image: /System/Library/CoreServices/Install in Progress.app/Contents/Resources/Installer.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing everything you need for your first day" >> $NOTIFY_LOG
echo "Command: MainText: All of the core apps you'll need are already being installed. Once we're ready to start, you'll find Google Chrome, Slack, and Zoom are all ready to go." >> $NOTIFY_LOG
sleep 5

#4 - Install Applications
##Jamf Triggers

echo "Command: Image: /System/Library/CoreServices/Install in Progress.app/Contents/Resources/Installer.icns" >> $NOTIFY_LOG
echo "Status: Setting Hostname..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Hostname"
sleep 5

echo "Command: Image: /usr/local/bin/SentinelOne.png" >> $NOTIFY_LOG
echo "Status: Installing SentinelOne..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-S1"
sleep 5

echo "Command: Image: /usr/local/bin/NessusAgent.jpg" >> $NOTIFY_LOG
echo "Status: Installing Nessus Agent..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Nessus"
sleep 5

echo "Command: Image: /usr/local/bin/Umbrella.icns" >> $NOTIFY_LOG
echo "Status: Installing Umbrella..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Umbrella"
sleep 5

echo "Command: Image: /usr/local/bin/Chrome.icns" >> $NOTIFY_LOG
echo "Status: Installing Google Chrome..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Chrome"
sleep 5

echo "Command: Image: /usr/local/bin/Zoom.icns" >> $NOTIFY_LOG
echo "Status: Installing Zoom..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Zoom"
sleep 5

echo "Command: Image: /usr/local/bin/slack.icns" >> $NOTIFY_LOG
echo "Status: Installing Slack..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-Slack"
sleep 5

echo "Command: Image: /usr/local/bin/Cleanup.png" >> $NOTIFY_LOG
echo "Status: Cleaning things up..." >> $NOTIFY_LOG
$JAMF_BINARY policy -event "JC-AuthChange"
sleep 5

# - Finishing up
echo "Status: Finishing up..." >> $NOTIFY_LOG
sleep 5

###Clean Up
sleep 3

echo "Command: Quit" >> $NOTIFY_LOG
sleep 1
