#!/bin/zsh
# EA to determine if Rosetta is installed on Apple Silicon macs
# Is this an Apple Silicon mac
if [[ $( /usr/bin/arch ) = arm64* ]];
then
	# Yes it is
    test=$( pgrep oahd 2>&1 >/dev/null ; echo $? )
	if [[ "$test" = "0" ]];
	then
		# It's installed
		echo "<result>Installed</result>"
	else
		# Missing
		echo "<result>Not Installed</result>"
	fi
else
	# No it is not
	echo "<result>Intel</result>"
fi
