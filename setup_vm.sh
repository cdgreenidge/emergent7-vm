#!/usr/bin/env bash

echo "==> Installing desktop environment"
apt-get update
apt-get upgrade -y
apt-get install ubuntu-desktop virtualbox-guest-x11 -y

# Set password for Ubuntu user to ubuntu
echo ubuntu:ubuntu | chpasswd
