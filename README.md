# emergent7-vm

This project uses Vagrant to create an Ubuntu 16.04 virtual machine,
and uses it to build [Emergent
7.0.1](https://grey.colorado.edu/emergent/index.php/Main_Page) from source.

Why a VM? Emergent 7.0.1 is near impossible to build from source on
modern platforms.  This automates the process and makes it impervious
to OS and dependency updates. It also makes it easy to modify the
Emergent source code (just edit the code in `/usr/src/emergent-7.0.1`,
and run `make && make install` to rebuild.)

### Prerequisites

> **Warning**: The VM needs at least 4GB of memory to build Emergent. Your
> computer should have >8GB to run the VM comfortably.

You will need to install [Vagrant](https://www.vagrantup.com) and
[VirtualBox](https://www.virtualbox.org). If you are on OSX and have
Homebrew, installed, you can do this with the following command:

```shell
$ brew cask install vagrant virtualbox
```

### Getting Started

Clone this repository anywhere:

```shell
$ git clone https://github.com/cdgreenidge/emergent7-vm
```

Inside the `emergent7-vm` directory you will find a `Vagrantfile` and
some scripts. To provision a virtual machine with Emergent7 installed,
run both of these commands from the `emergent7-vm` directory:

```
$ vagrant plugin install vagrant-disksize
$ vagrant up
```

Once the scripts finish, which could take several hours, restart the
VM:

```
$ vagrant halt
$ vagrant up
```

### Using the VM

There are two ways to start the VM:

1. Excute `vagrant up` from the `emergent7-vm` folder (recommended).
2. Start the `vagrant-emergent7-01_default...` VM from the VirtualBox interface.

Once you have started the VM, login with the following credentials:

```
Username: ubuntu
Password: ubuntu
```

You can start Emergent either by executing the `emergent` command in a terminal,
or double-clicking its desktop shortcut.

To share files between your computer and the VM, there is a special folder that
syncs between the host and guest systems. On the host system (your computer)
this is the `emergent7-vm` folder. On the guest system (the VM) this is located
at `/vagrant` (also accessible from `~/vagrant`).

### Gory Details
Here is what all the scripts are for:

- *Vagrantfile*: Contains the VM configuration.
- *install_emergent.sh*: Installs Emergent (and all of its dependencies).
- *setup_vm.sh*: Updates the VM and installs VirtualBox guest additions.
- *qt-installer.qs*: Automates the QT installer interface so it can be run
  in a script.

Here is what the scripts do (starting from a clean Ubuntu Xenial
server install):

1. Install Ubuntu desktop and VirtualBox guest additions
2. Install QT 5.1.2 to `/opt/Qt5.1.2`
3. Install as many emergent dependencies as possible from the Xenial
  repositories
4. Install Subversion, Open Dynamics Engine, and Quarter from source. All
  software from source is installed into `/usr/local`: tarballs are in
  `/usr/local/src/tars`, source trees are in `/usr/local/src`, binaries are in
  `/usr/local/bin`, etc.
5. Install Emergent from source

### Uninstalling
First, remove the VM. From the `emergent7-vm` directory:

```shell
$ vagrant destroy
```

Now, uninstall Vagrant and VirtualBox. If you used Homebrew to install them, you
can execute

```
$ brew cask uninstall vagrant virtualbox
$ brew cleanup
```

### Support
You can file an issue on the Github repository, or email Daniel Greenidge.
If you don't know his email, look on the
[Princeton Website](https://www.princeton.edu/search/people-advanced).
