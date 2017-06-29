# emergent7-vm

This project installs Emergent 7.0.1

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
simply run

```
$ vagrant plugin install vagrant-disksize
$ vagrant up
```

inside the `emergent7-vm` directory. Once the scripts finish, which
could take several hours, you can execute `vagrant up` inside this
directory to start a VM with Emergent 7.0.1 installed. You can also
start the VM from the VirtualBox program. Once the scripts finish,
restart the VM:

```
$ vagrant halt
$ vagrant up
```

The username for the VM is `ubuntu` and the password is `ubuntu`. The
`emergent7-vm` folder is mounted inside the VM at `/vagrant`, so you can
place files there and access them from both the host and the guest.

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
