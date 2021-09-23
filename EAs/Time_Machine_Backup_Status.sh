#!/bin/sh

lastBackupDateString=`tmutil latestbackup | rev | cut -d/ -f1 | rev`

if [ "$lastBackupDateString" == "" ]
  then
    echo "<result>Backup Data Not Available</result>"
  else
   echo "<result>$lastBackupDateString</result>"
 fi
