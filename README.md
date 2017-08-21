Usage
=====

Create Virtual Machine
----------------------

- Create a new VM:

      VMWare Fusion:
      File -> New -> Create a custom virtual machine
      Linux -> CentOS 64-bit

- Download a `CentOS-7-x86_64-Minimal-*.iso`
- Select the downloaded ISO as Disk Image for the new VM (and connect CD/DVD)
- Boot the new virtual machine
- Press TAB to customize boot params
- Add `ks=http://tiny.cc/et` to the boot params
- Press RETURN to start the installer
- Wait for anaconda installer to finish and reboot your VM (without disk image)

- Login: `etlegacy:etlegacy`

      ssh etlegacy@etlegacy.local


Install ET:Legacy
-----------------

```
git clone https://github.com/lukasgraf/etded-buildout.git -b etlegacy ~/etl-installer
cd ~/etl-installer
./install_etlegacy.sh
