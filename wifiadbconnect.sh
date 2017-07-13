#!/bin/bash
set -x #set flag to output commands on terminal 
adb tcpip 5555
sleep 5 #sleep for 5 seconds as Connections are restarted for TCP
adb connect "$(adb shell ip addr show wlan0  | grep 'inet ' | cut -d' ' -f6|cut -d/ -f1)"