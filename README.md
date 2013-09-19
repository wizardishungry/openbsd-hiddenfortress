openbsd-hiddenfortress
====================

Setup a minimal [OpenBSD](http://openbsd.org/) virtual machine with [Tor](https://www.torproject.org/) + [polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) + a few web browsers.
Intended as a quick way to provision a secure Tor environment for improved privacy and security.

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
- `vagrant ssh -- -X`
- `lynx -dump -nolist http://check.torproject.org/`

        Congratulations. Your browser is configured to use Tor.
        Please refer to the Tor website for further information about using Tor
        safely. You are now free to browse the Internet anonymously.

<pre>
                                     /)
                                    //
                  __*_             //
               /-(____)           //
              ////- -|\          //
           ,____o% -,_          //
          /  \\   |||  ;       //
         /____\....::./\      //
        _/__/#\_ _,,_/--\    //     THIS IS A SAMURAI
        /___/######## \/""-(\</
       _/__/ '#######  ""^(/</    NOT A NINJA
     __/ /   ,)))=:=(,    //.
    |,--\   /Q...... /.  (/     SO YOU FUCKING IDIOT BACON ZOMBIE
    /       .Q....../..\         NERDS DON'T EVEN GET STARTED
           /.Q ..../...\
          /......./.....\
          /...../  \.....\
          /_.._./   \..._\
           (` )      (` )
           | /        \ |
           '(          )'
          /+|          |+\
          |,/          \,/  b'ger
</pre>

