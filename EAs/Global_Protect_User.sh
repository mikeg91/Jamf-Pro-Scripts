#!/bin/sh

# gets logged in user for looking at directory
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# Location of Global Protect plist conatining user
file="/Users/$loggedInUser/com.paloaltonetworks.GlobalProtect.client"

# Reads Global Protect preferences for user
GPUser=$( defaults read ~/Library/Preferences/com.paloaltonetworks.GlobalProtect.client User)

echo "<result>$GPUser</result>"

exit 0
