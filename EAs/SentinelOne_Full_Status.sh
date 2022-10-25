#!/bin/bash

# Checks to see what site key is registered with SentinelOne

if [ -f "/usr/local/bin/sentinelctl" ] ; then 
    RESULT=$( sudo /usr/local/bin/sentinelctl status )
else
    RESULT="not installed"
fi

echo "<result>$RESULT</result>"
