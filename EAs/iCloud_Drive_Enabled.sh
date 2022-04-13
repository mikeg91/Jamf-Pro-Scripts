#!/bin/zsh

# Found on Jamf Nation from user PatrickD
# https://community.jamf.com/t5/jamf-pro/check-if-icloud-drive-is-enabled/m-p/256632/highlight/true#M237840

MobileDocsCount=$(ls -l /Users/*/Library/"Mobile Documents"/ | wc -l | sed 's/ //g')
MobileDocs=$(ls -l /Users/*/Library/ | grep "Mobile Documents" | wc -l | sed 's/ //g')

if [ $MobileDocs != 0 ]; then
        if [ $MobileDocsCount -le 1 ]; then
                echo "<result>Disabled</result>"
        else
                echo "<result>Enabled</result>"
        fi
else
        echo "<result>Disabled</result>"
fi
