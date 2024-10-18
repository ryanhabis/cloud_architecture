#!/bin/bash
# User data script for Azure Linux VM

# Package list update
apt -y update
apt -y upgrade

# Packages to install
apt -y install ngircd irssi xfce4 xfce4-session xrdp default-jre 

# XSession setup file
echo xfce4-session >~/.xsession

systemctl enable xrdp

adduser xrdp ssl-cert

systemctl restart xrdp

