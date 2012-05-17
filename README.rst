etded Buildout
================

A buildout configuration for installing and configuring
an Enemy Territory dedicated server including the NoQuarter
and Omnibot mods. The installation is completely isolated 
and everything is done within the repository directory.


Configurations
--------------

Buildout configurations:

:base.cfg:
    This is the only main configuration for now.
    Installs Enemy Territory in dedicated mode for running
    on servers. Installs a start script at ``bin/etded`` and
    some customized configs.

:version.cfg: Version pinnings.


Usage
-----

* Clone the git repository
* Symlink a main buildout configuration (e.g. *base.cfg*) to *buildout.cfg*:
  ``ln -s base.cfg buildout.cfg``
* Bootstrap buildout: ``python2.6 bootstrap.py``
* Run buildout: ``bin/buildout``
* Start the Enemy Territory server: ``bin/etded``


Links
-----

* http://www.splashdamage.com/wolfet/
