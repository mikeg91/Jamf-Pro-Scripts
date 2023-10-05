#!/bin/bash

Application="/Applications/Microsoft PowerPoint.app/Contents/MacOS/Microsoft Excel"

# Checks if the file or directory is there
if [ -e "$Application" ]; then

# Finds the install date and time from the meta data 
  InstalledOn=`mdls "$Application" -name kMDItemLastUsedDate | awk '{print $3,$4}'`
  echo "<result>$InstalledOn</result>"
else
  echo Not Installed
fi
