#!/usr/bin/env bash

# Updates the VM and isnstalls VirtualBox guest additions

echo "==> Installing desktop environment"
apt-get update
apt-get upgrade -y
apt-get install ubuntu-desktop virtualbox-guest-x11 -y

# Set password for Ubuntu user to ubuntu so we can login
echo ubuntu:ubuntu | chpasswd

# Give the ubuntu user write access to /usr/local and /vagrant in case
# the user wants to recompile code
setfacl -m u:ubuntu :rwx /usr/local
setfacl -m u:ubuntu :rwx /vagrant
