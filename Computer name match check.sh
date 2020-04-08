#!/bin/sh

#EA to show if LocalHostName, ComputerName and HostName are the same

SystemLocalHostName="$(scutil --get LocalHostName)"
SystemHostName="$(scutil --get HostName)"
SystemComputerName="$(scutil --get ComputerName)"

if [ $SystemHostName = $SystemLocalHostName ] && [ $SystemHostName = $SystemComputerName ] && [ $SystemComputerName = $SystemLocalHostName ] 
then
  echo "<result>Match<result>"
else
  echo "<result>Not Match<result>"

fi
