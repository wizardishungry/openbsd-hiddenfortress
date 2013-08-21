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
