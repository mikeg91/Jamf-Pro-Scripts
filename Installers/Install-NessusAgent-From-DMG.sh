#!/bin/sh

# Install-NessusAgent-From-DMG.sh
# Created by mikeg91
#
# Intended for use with Jamf Pro
# This will install a cached DMG of Nessus Agent in Jamf's Waiting room on your Mac. 
# 
# Set this script to run AFTER
# Make sure to enter the DMG name into Parameter 4 in the Script section

InstallerLocation="/Library/Application Support/JAMF/Waiting Room/$4"
echo "$InstallerLocation"

# Attach dmg
hdiutil attach "$InstallerLocation" -nobrowse

# Installs Nessus
installer -pkg /Volumes/Nessus\ Agent\ Install/Install\ Nessus\ Agent.pkg -target /

# Removes plugin db
rm /Library/NessusAgent/run/var/nessus/plugins-desc.db

# Configuring Nessus Agent
# MODIFY GROUP FOR YOUR ORG
echo "Configuring Nessus Agent"
/Library/NessusAgent/run/sbin/nessuscli agent link --key=YOURKEY --host=cloud.tenable.com --port=443 --groups="X" 

# Unmount DMG
hdiutil detach /Volumes/Nessus\ Agent\ Install

# Delete DMG
sudo rm "$InstallerLocation"

exit 0
