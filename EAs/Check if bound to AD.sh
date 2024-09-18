#!/bin/sh
# checks if bound to AD and reports AD name

ADDomainCheck=`dsconfigad -show | awk '/Active Directory Domain/{print $NF}'`

if [ "$ADDomainCheck" = "" ]; then
        result="Not Bound to Active Directory"
elif [ "$ADDomainCheck" != "" ]; then
        result=$ADDomainCheck
fi

echo "<result>$result</result>"
exit 0
