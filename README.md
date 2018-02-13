# openbsd-hiddenfortress

Intended as a quick way to provision an OpenBSD 6.2 machine inside VirtualBox for a distraction-free desktop.
Also includes a semi-jailed [Tor](https://www.torproject.org/) user.

## What it does
1. Setup a minimal [OpenBSD](http://openbsd.org/) virtual machine with X11 and ssh access.
2. Set the `vagrant` user to copy over dotfiles.
3. Setup a delegate user (`tor`) for [Tor](https://www.torproject.org/) + [polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) + a few web browsers.

- ***This is not intended as a replacement for the integrated security provided by the Tor Browser bundle!***
- ***Virtualization software is bug ridden; this is not intended to have the same security as running OpenBSD on dedicated hardware.***

## Prerequisites
- Working [Vagrant](http://www.vagrantup.com/) install
  - Install [vagrant-triggers](https://github.com/emyl/vagrant-triggers) `vagrant plugin install vagrant-triggers`
- [VirtualBox](https://www.virtualbox.org/)
- ssh client

## Instructions
------------
- `vagrant up`
- `vagrant ssh`
- or login in the VirtualBox window

## Tor Operation
There should be a user added called `tor`. Connect by:
```bash
SSH_USER=tor vagrant ssh
```
There are packet filters that block any non-tor network activity from this user.

### Browsers Available + Verified
- [Chrome / Chromium](https://www.chromium.org/Home) -- launch with `chrome --proxy-server="127.0.0.1:8123" http://check.torproject.org/`
- [Curl](http://curl.haxx.se/)
- [Firefox](https://mozilla.org/) -- manually input proxy settings
- [Lynx](http://lynx.browser.org/)
- [W3m](http://w3m.sourceforge.net/)

### Verifying Tor Privacy
- `lynx -dump -nolist http://check.torproject.org/`
```
        Congratulations. Your browser is configured to use Tor.
        Please refer to the Tor website for further information about using Tor
        safely. You are now free to browse the Internet anonymously.
```

### Additional Configuration Options
- You can add TOR [bridges](https://www.torproject.org/docs/bridges.html.en) by putting them in `TORRC_APPEND`

```
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
```
