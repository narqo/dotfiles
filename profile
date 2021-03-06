# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export LANG=en_US.UTF-8

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -r "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi
