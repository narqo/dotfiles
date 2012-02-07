# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# Make some commands not show up in history
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"

# append to the history file, don't overwrite it
shopt -s histappend

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
	. `brew --prefix`/Library/Contributions/brew_bash_completion.sh
fi

export EDITOR=vim

# Pip download cache directory path
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip

# Virtualenvwrapper Shell Startup File
#export VIRTUALENVWRAPPER_PYTHON=`brew --prefix`/Cellar/python/2.7.1/bin/python
export WORKON_HOME=$HOME/.virtualenvs
if [ -f `brew --prefix`/share/python/virtualenvwrapper.sh ]; then
	source `brew --prefix`/share/python/virtualenvwrapper.sh
fi

# Node.js libraries path 
export NODE_PATH=`npm root -g`

