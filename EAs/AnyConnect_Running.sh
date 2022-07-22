#!/bin/sh

# Defines file to look for 
file="/opt/cisco/anyconnect/acumbrellaagent"

# checks if file is on location specified above echos Running or echos Not Running
if [ ! -f "$file" ]; then
	echo "<result>Running</result>"
    
else
    echo "<result>Not Running</result>"
fi
