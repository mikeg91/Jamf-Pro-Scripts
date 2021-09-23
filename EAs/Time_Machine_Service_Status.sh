#!/bin/sh
enabled=`/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine AutoBackup`
	
if [ "$enabled" == "1" ];then
echo "<result>Enabled</result>"
else
echo "<result>Disabled</result>"
fi
	
