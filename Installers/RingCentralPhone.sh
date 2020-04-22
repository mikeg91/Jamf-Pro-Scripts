#!/bin/sh

####################################################################################################
#
# RingCentral for Mac.app Installation Script
#
####################################################################################################
#
# DESCRIPTION
#
# Automatically download and install or upgrade the latest version of the
# RingCentral for Mac.app VOIP application
#
####################################################################################################
#
# HISTORY
#
# Created by Caine Hörr on 2017-03-14
#
# v1.3 - 2019-05-09 - Michael Grady
# Updated copy from path in line 113
# Updated unmount for dmg post install in line 118
#
# v1.2 - 2017-03-16 - Caine Hörr
# Set all URLs to use https (SSL)
# Added the following line: echo "Downloading from:" ${VendorURL}${VendorRelativeFilenamePath} for logging purposes
#
# v1.1 - 2017-03-15 - Caine Hörr
# Added -i flag to VendorRelativeFilenamePath="$( curl -sI $VendorDownloadURL | grep -i "location" | awk '{ print $2 }' )"
# Added sudo to sudo rm -rf /Applications/RingCentral\ for\ Mac.app
#
# v1.0 - 2017-03-14 - Caine Hörr
# Initial RingCentral for Mac.app Installation Script
#

#
# THESE VALUES ARE EDITABLE...
#

# Vendor URL
VendorURL="https://downloads.ringcentral.com"

# Vendor Download URL
VendorDownloadURL="https://downloads.ringcentral.com/sp/RingCentralForMac"

# Local directory to save to...
LocalSaveDirectory="/tmp/"

# DMG Mount Point
DMGMountPoint="/Volumes/RingCentral\ for\ Mac"

#
# DO NOT EDIT BELOW THIS LINE
#

# Check to see if RingCentral for Mac already exists in /Applications
CheckForRingCentralApp="$(ls /Applications/ | grep "RingCentral for Mac")"

if [ "$CheckForRingCentralApp" = "RingCentral for Mac.app" ]; then
  echo "RingCentral for Mac.app currently installed..."

   # Check to see if RingCentral for Mac is running
    RingCentralRunning="$(ps aux | grep "/Applications/RingCentral for Mac.app/Contents/MacOS/Softphone" | awk '{ print $11 }' | grep "/Applications/RingCentral")"

    if [ "$RingCentralRunning" = "/Applications/RingCentral" ]; then
      echo "RingCentral for Map.app is running..."
      echo "Quitting RingCentral for Mac.app..."

      # Gracefully Quit RingCentral for Mac.app
      osascript -e 'quit app "RingCentral for Mac"'
    else
      echo "RingCentral for Map.app is not running..."
    fi

    echo "Deleting /Applications/RingCentral for Mac.app..."
    rm -rf /Applications/RingCentral\ for\ Mac.app

else
  echo "RingCentral for Mac.app not currently installed..."
fi

echo "Installing latest version of RingCentral for Mac.app..."
echo ""

# Vendor Relative Path to File
VendorRelativeFilenamePath="$( curl -sI $VendorDownloadURL | grep Location | awk '{ print $2 }' )"
echo "Downloading from:" ${VendorURL}${VendorRelativeFilenamePath}
echo

# Remove \r (CR) at the end ( 0d )
VendorRelativeFilenamePath=${VendorRelativeFilenamePath%$'\r'}

# Vendor Dynamic Filename as Downloaded
VendorDynamicFilename="${VendorRelativeFilenamePath##*/}"

# Vendor Full Download URL
VendorFullDownloadURL=${VendorURL}${VendorRelativeFilenamePath}

# Download vendor supplied DMG file to local save directory
curl ${VendorFullDownloadURL} -o ${LocalSaveDirectory}${VendorDynamicFilename}

# Mount vendor supplied DMG File
echo "Mounting" ${LocalSaveDirectory}${VendorDynamicFilename} "..."
hdiutil attach ${LocalSaveDirectory}${VendorDynamicFilename} -nobrowse

# Copy contents of vendor supplied DMG file to /Applications/
# Preserve all file attributes and ACLs
echo "Copying RingCentral for Mac.app into the /Applications/ folder..."
cp -pPR /Volumes/RingCentral\ Phone/RingCentral\ for\ Mac.app /Applications/



# Identify the exact mount point for the DMG file
#ProperDMGMountPoint="$(hdiutil info | grep "$image-path" | awk '{ print $1 }')"

# Unmount the vendor supplied DMG file
echo "Unmounting" RingCentral Installer"..."
hdiutil detach /Volumes/RingCentral\ Phone


# Remove the downloaded vendor supplied DMG file
echo "Removing" ${LocalSaveDirectory}${VendorDynamicFilename}"..."
rm -f $LocalSaveDirectory$VendorDynamicFilename

# Launch RingCentral for Mac.app
open /Applications/RingCentral\ for\ Mac.app

echo "Installation complete!"
