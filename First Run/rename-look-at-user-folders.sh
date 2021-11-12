
#!/bin/sh

#gets current logged in user from home directory names
getUser=$(ls  "/Users/" | grep -v '^[.*]' | grep -v '.admin' | grep -v 'Administrator' | grep -v 'administrator'| grep -v 'Guest' |  grep -v 'Shared')

# gets serial number of device, counts back 4 characters and adds dash ie -1234
serial_no=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}' | tail -c 5)


#gets named
firstInitial=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
lastName=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($3)}' | cut -c 1-10)

# combines everything for device name
computerName=${firstInitial}${lastName}-${serial_no}

#set all the name in all the places
scutil --set ComputerName "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"

dscacheutil -flushcache


