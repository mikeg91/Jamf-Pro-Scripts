#!/bin/sh

# Compares Host Name, Computer Name, and Local Host Name to see if they match. 
# Some apps pull different names, so helpful to know. 

SystemLocalHostName="$(scutil --get LocalHostName)"
SystemHostName="$(scutil --get HostName)"
SystemComputerName="$(scutil --get ComputerName)"

if [ $SystemHostName = $SystemLocalHostName ] && [ $SystemHostName = $SystemComputerName ] && [ $SystemComputerName = $SystemLocalHostName ] 
then
  echo "<result>Match</result>"
else
  echo "<result>Not Match</result>"

fi
