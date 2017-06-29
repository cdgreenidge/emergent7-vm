#! /usr/bin/env bash

# The directory in which to install Quarter and Emergent. If you change this,
# be sure to update emergent.desktop (the desktop shortcut) as well.
export PREFIX=/usr/local

# The directory in which to install Qt
export QTPREFIX=/opt/Qt5.2.1

# The path to the QT installation
export QTDIR=$QTPREFIX/5.2.1/gcc_64

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/bin:$PATH
export CFLAGS=-I/usr/include $CFLAGS
export CXXFLAGS=-I/usr/include $CXXFLAGS

# Install as many of Emergent's dependencies we can through the package manger.
# This function installs general build tools as well so it should be run first.
install_deps() {
    DEPS="cmake libcoin80-dev libgsl-dev libjpeg-dev libpng-dev \
libreadline-dev libsndfile-dev pkg-config subversion zlib1g-dev \
build-essential libfontconfig1-dev libfreetype6-dev libx11-dev libxfixes-dev \
libxi-dev libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev \
libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev \
libxcb-sync0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev \
libxcb-render-util0-dev xvfb libncurses-dev libsqlite3-dev \
libgstreamer-plugins-base0.10-dev"
    apt-get update
    apt-get install $DEPS -y
}


download_qt() {
    wget \
https://download.qt.io/archive/qt/5.2/5.2.1/qt-opensource-linux-x64-5.2.1.run
}


install_qt() {
    # Start a virtual X framebuffer to keep the QT installer happy
    Xvfb :10 -ac -screen 0 1024x768x24 &
    PID=$!
    DISPLAY=:10 ./qt-opensource-linux-x64-5.2.1.run --script qt-installer.qs
    kill -15 $PID
    rm qt-opensource-linux-x64-5.2.1.run
}


# Emergent depends on SVN 1.8.x, but Xenial only provides 1.9+ in repos
download_svn() {
    mkdir -p /usr/local/src/tars
    cd /usr/local/src/tars
    wget http://mirror.nexcess.net/apache/subversion/subversion-1.8.17.tar.gz
    cd ..
    tar -xzf tars/subversion-1.8.17.tar.gz
}


install_svn() {
    cd /usr/local/src/subversion-1.8.17
    ./configure --prefix=$PREFIX
    make -j4 && make install
}


# The ODE version in the Xenial repos causes compile errors, so we
# install from source
download_ode() {
    mkdir -p /usr/local/src/tars
    cd /usr/local/src/tars
    wget \
https://downloads.sourceforge.net/project/opende/ODE/0.13/ode-0.13.tar.bz2
    cd ..
    tar -xjf tars/ode-0.13.tar.bz2
}


install_ode() {
    cd /usr/local/src/ode-0.13
    ./configure --prefix=$PREFIX --enable-shared
    make && make install
}


download_quarter() {
    mkdir -p /usr/local/src
    cd /usr/local/src
    svn co -q --username anonymous --password emergent\
        https://grey.colorado.edu/svn/coin3d/quarter/trunk quarter-trunk
}


install_quarter() {
    cd /usr/local/src/quarter-trunk
    export CPPFLAGS="-I$QTDIR/include/QtCore -I$QTDIR/include/QtWidgets \
-I$QTDIR/include/QtOpenGL -I$QTDIR/include/QtGui -fPIC"
    export CONFIG_QTLIBS="-lQt5Core -lQt5Widgets -lQt5OpenGL -lQt5Gui \
-lQt5Designer -lQt5UiTools -lQt5Xml -l:libicui18n.so.51 -l:libicuuc.so.51 \
-l:libicudata.so.51"
    ./configure --prefix=$PREFIX --disable-pkgconfig --disable-debug\
                --with-qt=$QTDIR \
                --with-qt-designer-plugin-path=$QTDIR/plugins/designer
    make -j8 && make install
    unset CONFIG_QTLIBS
    unset CPPFLAGS
}


download_emergent() {
    mkdir -p /usr/local/src
    cd /usr/local/src
    svn co -q https://grey.colorado.edu/svn/emergent/emergent/tags/7.0.1/\
        emergent-7.0.1
}


install_emergent() {
    cd /usr/local/src/emergent-7.0.1
    ./configure --prefix=$PREFIX --qt5 --flags="-DCMAKE_PREFIX_PATH=$PREFIX"
    make -j4 && make install
}


loose_ends() {
    # Modify path
    echo "export LD_LIBRARY_PATH=$PREFIX/lib:"'$LD_LIBRARY_PATH' \
         >> ~/.bashrc
    echo "export PATH=$PREFIX/bin:"'$PATH' >> ~/.bashrc

    # Create shortcut on desktop
    ln -s /vagrant ~/Desktop/vagrant
    ln -s $PREFIX/bin/emergent ~/Desktop/emergent

    # Rebuild the dynamic library cache
    ldconfig
}


echo "==> Installing build dependencies"
install_deps

echo "==> Downloading Subversion 1.8.17 to /usr/local/src"
#download_svn

echo "==> Installing Subversion 1.8.17 to /usr/local"
# install_svn

echo "==> Downloading Qt5.2.1"
# download_qt

echo "==> Installing Qt5.2.1 to /opt/Qt5.2.1"
# install_qt

echo "==> Downloading Open Dynamics Engine to /usr/local/src"
# download_ode

echo "==> Installing Open Dynamics Engine to /usr/local"
#install_ode

echo "==> Downloading Quarter to /usr/local/src"
# download_quarter

echo "==> Installing Quarter to /usr/local"
# install_quarter

echo "==> Downloading Emergent to /usr/local/src"
# download_emergent

echo "==> Installing Emergent to /usr/local"
install_emergent

echo "==> Tying up loose ends"
# loose_ends

echo "==> Success!"
