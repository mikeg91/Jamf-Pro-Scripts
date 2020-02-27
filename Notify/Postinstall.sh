#!/bin/bash

# postinstall script for:
# Jamf Combo Installer for DEP Prestage

TMP_PATH=/private/tmp
LOGIN_FILENAME=JamfConnectLoginOkta-1.9.0.pkg
VERIFY_FILENAME=JamfConnectVerify-x.pkg
SYNC_FILENAME=JamfConnectSync-1.2.2.pkg

# Install Login
installer -pkg "$TMP_PATH"/"$LOGIN_FILENAME" -target 

# if Okta installation, use this command:
installer -pkg "$TMP_PATH"/"$SYNC_FILENAME" -target 

# FANCY VERSION: Okta with EULA and post login script with Notify mechanism
/usr/local/bin/authchanger -reset -Okta —DefaultJCRight -preAuth JamfConnectLogin:RunScript,privileged -postAuth JamfConnectLogin:Notify
#/usr/local/bin/authchanger -reset -Okta -preAuth JamfConnectLogin:RunScript,privileged

# BASIC VERSION: Just Okta Login.  No scripting or EULA.
# /usr/local/bin/authchanger -reset -Okta


# Use the killall command to make sure that a slow network connection will kill the standard macOS login window after the pkg has fully installed.
/usr/bin/killall -9 loginwindow

exit 0      ## Success
exit 1      ## Fail

