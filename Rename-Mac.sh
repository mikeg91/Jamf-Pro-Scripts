#!/bin/sh

# gets current logged in user
getUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
echo $getUser

if [ "$getUser" = "sysman" ] || [ "$getUser" = "console root" ] || [ "$getUser" = "setup user" ] || [ "$getUser" = "_mbsetupuser" ] || [ "$getUser" = " " ]; 
  then echo "Unable to validate console user, waiting."
    sleep 120
fi

# gets serial number of device, counts back 4 characters and adds dash ie -1234
serial_no=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}' | tail -c 5)

# gets named
firstInitial=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
lastName=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($3)}' | cut -c 1-10)
echo $getUser
echo $firstInitial
echo $lastName

# combines everything for device name
computerName=${firstInitial}${lastName}-${serial_no}

echo $computerName

# set all the name in all the places
scutil --set ComputerName "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"

dscacheutil -flushcache
