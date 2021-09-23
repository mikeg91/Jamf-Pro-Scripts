#!/bin/sh

# updated Jan 15 2020 for v8 support
# https://www.jamf.com/jamf-nation/discussions/18592/extension-attribute-tenable-network-security-nessus#responseChild207258
# 

# Check to see if Nessus Agent is installed

RESULT="N/A"

if [ -f /Library/NessusAgent/run/sbin/nessuscli ]; then
    OUTPUT=$(/Library/NessusAgent/run/sbin/nessuscli -v | head -n 1)
    if [[ ${OUTPUT} == *"(Nessus) 7"* ]]; then
        RESULT="$(echo ${OUTPUT} | awk 'NR==1{print $3 " " $4 " " $5}')"
    elif [[ ${OUTPUT} == *"(Nessus Agent) 8"* ]]; then
         RESULT="$(echo ${OUTPUT} | awk 'NR==1{print $4 " " $5 " " $6}')"
    else # catch-all to capture at least something
        RESULT=${OUTPUT}
    fi
fi

echo "<result>${RESULT}</result>"
