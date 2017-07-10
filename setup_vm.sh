#! /usr/bin/env bash

# Add the user to the vboxsf group so we can mount shared folders
usermod -a -G vboxsf ubuntu

# Allow writing to /usr/local/src so we can recompile code
setfacl -m u:ubuntu:rwx /usr/local

# Enable the root user
echo "root:ubuntu" | chpasswd
