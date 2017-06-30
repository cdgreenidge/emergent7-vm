#!/usr/bin/env bash

# Updates the VM and isnstalls VirtualBox guest additions

echo "==> Installing desktop environment"
apt-get update
apt-get upgrade -y
apt-get install ubuntu-desktop virtualbox-guest-x11 -y

# Set password for Ubuntu user to ubuntu so we can login
echo ubuntu:ubuntu | chpasswd
