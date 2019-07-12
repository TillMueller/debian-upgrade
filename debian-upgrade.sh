#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

needrestart
apt-mark showhold

read -p "No packages should be shown as on hold above. Continue with update & upgrade on current version?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

apt update
apt upgrade

read -p "Continue with full upgrade?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

apt full-upgrade

read -p "Continue with autoremove?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

apt autoremove

read -p "Edit sources list to move stretch to buster?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

sed -i 's/stretch/buster/g' /etc/apt/sources.list
sed -i 's/stretch/buster/g' /etc/apt/sources.list.d/*.list

read -p "Upgrade to buster?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

apt update
apt upgrade