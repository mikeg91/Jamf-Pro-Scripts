#!/usr/bin/env bash
# TITLE: Time Machine Encryption Status


backupMountpoint=$(/usr/bin/tmutil destinationinfo | /usr/bin/grep "Mount Point" | /usr/bin/awk -F ": " '{print $2}')
if [[ -z "$backupMountpoint" ]]; then
    if [[ $(/usr/bin/tmutil destinationinfo | /usr/bin/awk -F ": " '{print $2}') = "No destinations configured." ]]; then
        result="TimeMachine not used"
    else
        result="Status unknown"
    fi
else
    encryptDrive=$(df -h | /usr/bin/grep "$backupMountpoint" | /usr/bin/awk '{print $1}')
    encryptStatus=$(/usr/sbin/diskutil cs info "$encryptDrive" | /usr/bin/grep "Conversion State" | /usr/bin/awk '{print $3}')
    if [[ -z "$encryptStatus" ]]; then
        result="Not Encrypted"
    else
        result="$encryptStatus"
    fi
fi
echo "<result>$result</result>"
exit 0
