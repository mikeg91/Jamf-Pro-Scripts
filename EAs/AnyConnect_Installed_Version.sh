#!/bin/bash

anyConnectVersion=$(/opt/cisco/anyconnect/bin/vpn stats | grep "Cisco AnyConnect Secure Mobility Client" | awk -F"[()]" '{print $2}')

if [[ "$anyConnectVersion" != "" ]]; then
        echo "<result>$anyConnectVersion</result>"
else
        echo "<result>Not installed</result>"
fi
