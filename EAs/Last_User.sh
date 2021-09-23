#!/bin/sh
#
# This attribute displays the last user to log in.

lastUser=`defaults read /Library/Preferences/com.apple.loginwindow lastUserName`

if [ $lastUser == "" ]; then
	echo "<result>No logins</result>"
else
	echo "<result>$lastUser</result>"
fi
