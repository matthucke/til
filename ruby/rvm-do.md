# rvm do

In an interactive shell, **rvm** replaces `cd` with a function.  Every time
you change directories, it reads in `.ruby-version` and `.ruby-gemset`, switching to 
that environment.

That's fine for interactive shells, but cron jobs and anything launched from init
need to explicitly set up the environment.  Even a cron job that executes "cd" won't
pick up the shell functions defined by RVM - and will thus use the wrong ruby.

"rvm do" is the solution.


    Usage:
    rvm in <path> do <some-command>

"." is a perfectly cromulent path.  Thus my cron job becomes:

    cd /srv/webapps/app_name && /usr/local/rvm/bin/rvm in . do script/whatever


