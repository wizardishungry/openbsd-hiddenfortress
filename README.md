openbsd-hiddenfortress SOCKS!!!!!
====================

Setup a minimal [OpenBSD](http://openbsd.org/) virtual machine with [polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) + a few web browsers.

Browsers Available + Verified
-----------------------------
**X11 browsers are not going to work unless you monkey with the Vagrantfile right now!**
- [Chrome / Chromium](http://www.chromium.org/Home) -- launch with `chrome --proxy-server="127.0.0.1:8123" http://check.torproject.org/`
- [Curl](http://curl.haxx.se/)
- Firefox -- manually input proxy settings
- [Lynx](http://lynx.browser.org/)
- [W3m](http://w3m.sourceforge.net/)

Prerequisites
-------------
- Working [Vagrant](http://www.vagrantup.com/) install -- known to work with 1.2.2; see [#8](https://github.com/WIZARDISHUNGRY/openbsd-hiddenfortress/issues/8)
- [VirtualBox](https://www.virtualbox.org/)
- Ssh client
- X11 Install _(Graphical browsers coming soon!)_

Instructions
------------
- `vagrant up`
- *ignore warnings about missing interface or change_host_name capability*
- `vagrant provision`
- `vagrant ssh -- -XA`
- `ssh -fND 9050 user@host.example.com`
- `lynx -dump -nolist http://www.cnn.com/`
</pre>
