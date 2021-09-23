#!/bin/bash

FwareCheck=$(sudo firmwarepasswd -check)
arch=$(/usr/bin/arch)

if [ "$arch" == "arm64" ];
then
  echo "<result>ARM Chip Not Supported</result>"
  fi
if [ "$FwareCheck" = "Password Enabled: Yes" ];
then
    echo "<result>Enabled</result>"
else
    echo "<result>Disabled</result>"
fi

