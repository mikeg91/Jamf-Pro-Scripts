#!/bin/sh

# gets logged in user for looking at directory
loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# Location of state file
file="/Users/$loggedInUser/Library/Preferences/com.jamf.connect.state.plist"

# determines if Jamf Connect state plist is present if not script ends
# if it is present then it runs JSS username script
if [ ! -f "$file" ]; then
    echo Jamf Connect Hasnt run

else
	echo Jamf Connect has been run
    jamfConnectUser=$(defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.state.plist DisplayName)
    echo $jamfConnectUser
    # Sets Username field in Jamf to be Okta email address
    jamf recon -endUsername $jamfConnectUser
fi
