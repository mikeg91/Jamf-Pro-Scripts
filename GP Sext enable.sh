#!/bin/sh

# Created October 1 2020 by Mike Grady 
#
# What it does.
# Creates file that GP will see and triggers system extension install while being pushed from MDM 

# Creates folder for file
/bin/mkdir -p "/Library/Application Support/PaloAltoNetworks/GlobalProtect"

# Creates File
/usr/bin/touch "/Library/Application Support/PaloAltoNetworks/GlobalProtect/install_system_extensions.now"
