# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/share/python:$PATH

export LANG=ru_RU.UTF-8

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH=$HOME/bin:$PATH
fi

PATH=./node_modules/.bin:$PATH
