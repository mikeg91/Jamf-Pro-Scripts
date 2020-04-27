#!/bin/bash

# postinstall script for:
# Jamf Combo Installer for DEP Prestage

# Install Jamf Connect Login
installer -pkg /tmp/JamfConnectLogin-1.9.0-okta.pkg -target /

# Install Jamf Connect Sync
installer -pkg /tmp/JamfConnectSync-1.2.2.pkg -target /

# Set JCL to use Okta as auth source and run Notify Script afterwards
/usr/local/bin/authchanger -reset -Okta -postAuth JamfConnectLogin:Notify JamfConnectLogin:RunScript,privileged

/usr/bin/killall -9 loginwindow

exit 0      ## Success
exit 1      ## Fail
