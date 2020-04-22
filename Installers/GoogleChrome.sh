#!/bin/sh

####################################################################################################
#
# Google Chrome Installation Script
#
####################################################################################################
#
# DESCRIPTION
#
# Automatically download and install Google Chrome
#
####################################################################################################
# 
# HISTORY
#
# Created by Caine Hörr on 2016-07-25
# https://www.jamf.com/jamf-nation/discussions/20894
# v1.0 - 2016-07-25 - Caine Hörr
# Initial Google Chrome Installation script
#
# v1.1 - 2016-10-11 - Caine Hörr
# Added -nobrowse flag to hdiutil attach /tmp/$VendorDMG command line arguments
# 
# v1.2 - Feb 29, 2020 - Mike Grady
# Removed section to auto open chrome post install
#



# Vendor supplied DMG file
VendorDMG="googlechrome.dmg"

# Download vendor supplied DMG file into /tmp/
curl https://dl.google.com/chrome/mac/stable/GGRO/$VendorDMG -o /tmp/$VendorDMG

# Mount vendor supplied DMG File
hdiutil attach /tmp/$VendorDMG -nobrowse

# Copy contents of vendor supplied DMG file to /Applications/
# Preserve all file attributes and ACLs
cp -pPR /Volumes/Google\ Chrome/Google\ Chrome.app /Applications/

# Identify the correct mount point for the vendor supplied DMG file 
GoogleChromeDMG="$(hdiutil info | grep "/Volumes/Google Chrome" | awk '{ print $1 }')"

# Unmount the vendor supplied DMG file
hdiutil detach $GoogleChromeDMG | logger

# Remove the downloaded vendor supplied DMG file
rm -f /tmp/$VendorDM

echo "Installation complete!"
