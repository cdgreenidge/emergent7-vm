#! /usr/bin/env bash

# This script installs Emergent 7.0.1 and its dependencies.

set -e
source ./emergent.sh

echo "==> Installing build dependencies"
install_deps

echo "==> Downloading Subversion 1.8.17 to /usr/local/src"
download_svn

echo "==> Installing Subversion 1.8.17 to /usr/local"
install_svn

echo "==> Downloading Qt5.2.1"
download_qt

echo "==> Installing Qt5.2.1 to /opt/Qt5.2.1"
cd ~/Downloads
install_qt

echo "==> Downloading Open Dynamics Engine to /usr/local/src"
download_ode

echo "==> Installing Open Dynamics Engine to /usr/local"
install_ode

echo "==> Downloading Quarter to /usr/local/src"
download_quarter

echo "==> Installing Quarter to /usr/local"
install_quarter

echo "==> Downloading Emergent to /usr/local/src"
download_emergent

echo "==> Installing Emergent to /usr/local"
install_emergent

echo "==> Tying up loose ends"
loose_ends

echo "==> Finished!"
