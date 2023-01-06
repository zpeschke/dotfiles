# home
My configuration files and scripts

# Templates

You can create template files for your configurations by embedding POSIX shell if statement conditions. For example, here are the contents of a sample template file.

```
$ cat sample.template 
first line
<% $(uname -s) = "OpenBSD" %>
this is openbsd
<% end %>
<% $(uname -s) = "Linux" %>
this is linux
<% end %>
third line
```

If you parse this template with the [`bin/parse-template.sh`](https://github.com/zpeschke/home/blob/master/bin/parse-template.sh) script, the output is the following on my system:

```
$ bin/parse-template.sh sample.template 
first line
this is openbsd
third line
```

Currently, only if statement conditions are supported. The condition can be any supported POSIX shell condition and can include any commands that exist in your system. Treat it as a standard shell if statement.

Embedded conditions do not work at this time.

# Deploy

The [`deploy.sh`](https://github.com/zpeschke/home/blob/master/deploy.sh) script can be used to deploy files and templates to whichever location you desire. Any file ending in extenstion `.template` will be parsed by the [`bin/parse-template.sh`](https://github.com/zpeschke/home/blob/master/bin/parse-template.sh) script before being deployed. The source and destination maps should be defined within [`maps.txt`](https://github.com/zpeschke/home/blob/master/map.txt). The source should be the relevant path to a file within the current working directory. Here is an example [`maps.txt`](https://github.com/zpeschke/home/blob/master/map.txt) file:

```
$ cat map.txt 
conf/Xresources         ~/.Xresources
conf/tmux.conf.template ~/.tmux.conf
conf/vimrc              ~/.vimrc
```

Here is the usage of [`deploy.sh`](https://github.com/zpeschke/home/blob/master/deploy.sh):

```
$ ./deploy.sh 
Usage: ./deploy.sh -a
       ./deploy.sh pattern [pattern] [...]
```

* `-a` will deploy all files defined in [`map.txt`](https://github.com/zpeschke/home/blob/master/map.txt).
* `pattern [pattern] [...]` will only deploy files matching the extended grep patterns provided.

Below are some examples:

```
# deploy all files defined in map.txt
$ ./deploy.sh -a
conf/Xresources -> /home/user/.Xresources
conf/tmux.conf -> /home/user/.tmux.conf
conf/vimrc -> /home/user/.vimrc
```

```
# deploy vimrc file only
$ ./deploy.sh vimrc
conf/vimrc -> /home/user/.vimrc
```

```
# deploy vimrc and tmux only
$ ./deploy.sh vimrc tmux
conf/tmux.conf -> /home/user/.tmux.conf
conf/vimrc -> /home/user/.vimrc
```

```
# deploy everything in conf/ path
$ ./deploy.sh conf/     
conf/Xresources -> /home/user/.Xresources
conf/tmux.conf -> /home/user/.tmux.conf
conf/vimrc -> /home/user/.vimrc
```
