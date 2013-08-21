openbsd-mifune
====================
*A Hidden Fortress!*

Vagrantfile to setup a minimal OpenBSD install with tor+polipo+web_browsers.

Instructions
------------
- `vagrant up`
- *ignore warnings about missing interface*
- `vagrant provision`
- `vagrant ssh`
- ` lynx -dump -nolist http://check.torproject.org/`
