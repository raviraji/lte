#!/bin/bash
echo "==============================================================================="
dEVnAme=$(cat /etc/remote-iot/configure | grep name)
dEVnAme=${dEVnAme:5}
echo "device Name="$dEVnAme
echo "-----------------------------------------------------------------"
hOST=$(cat /etc/hostname)
echo "device ID ="$hOST
echo "==============================================================================="
wLAN0oUT=$(nmcli | grep wlan0)
wLAN0oUT=${wLAN0oUT:0:-62}
echo "wlan0 wifi stataus="$wLAN0oUT
Eth0=$(nmcli | grep eth0:)
Eth0=${Eth0:4}
echo "Ethernet Connection status "$Eth0
LtE=$(nmcli | grep cdc-wdm0:)
LtE=${LtE:8}
echo "LTE status "$LtE
echo "-------------------------------------------------------------------------------"
echo "                                  END                                          "
echo "-------------------------------------------------------------------------------"
