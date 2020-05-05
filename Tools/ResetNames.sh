
#!/bin/sh

# Used to rename a mac using current logged in user

# gets current logged in user
getUser=$(ls -l /dev/console | awk '{ print $3 }')

# gets serial number of device, counts back 4 characters and adds dash ie -1234
serial_no=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}' | tail -c 5)

# gets username
firstInitial=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
lastName=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($3)}' | cut -c 1-10)

# combines everything for device name
computerName=${firstInitial}${lastName}-${serial_no}

echo $computerName

# set all the name in all the places
scutil --set ComputerName "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"

dscacheutil -flushcache
