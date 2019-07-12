#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

needrestart
apt-mark showhold
apt update
apt upgrade
apt full-upgrade
apt autoremove
sed -i 's/stretch/buster/g' /etc/apt/sources.list
sed -i 's/stretch/buster/g' /etc/apt/sources.list.d/*.list
apt update
apt upgrade