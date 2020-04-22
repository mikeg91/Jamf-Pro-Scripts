#!/bin/bash

# runs as part of notify.
# uses home directory to find user who signed into Jamf Connect Login
# Pulls username from plist and updates jss
# 

# finds first time login user by looking at directory
loggedInUser=$(ls  "/Users/" | grep -v '^[.*]' | grep -v '.admin' | grep -v 'Administrator' | grep -v 'administrator'| grep -v 'Guest' | grep -v 'Shared')
echo $loggedInUser

# finds username via JCS plist
jamfConnectUser=$(defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync.plist UserLoginName)
echo $jamfConnectUser

# runs recon to update jamf
jamf recon -endUsername $jamfConnectUser
