#!/bin/bash

#Tells number of times battery has been cycled.

echo "<result>$(system_profiler SPPowerDataType | awk '/Cycle Count/{print $NF}')</result>"

