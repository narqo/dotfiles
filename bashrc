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
export HISTIGNORE="ls:cd:cd -:pwd;exit:date:* --help"

# append to the history file, don't overwrite it
shopt -s histappend

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f ~/.bash_aliases ] && \
    source ~/.bash_aliases

# Enable programmable completion features
[ -f `brew --prefix`/etc/bash_completion ] && \
    source `brew --prefix`/etc/bash_completion

[ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ] && \
    source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" \
    -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

export EDITOR=vim

# Pip download cache directory path
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip

# Virtualenvwrapper Shell Startup File
#export VIRTUALENVWRAPPER_PYTHON=`brew --prefix`/Cellar/python/2.7.1/bin/python
export WORKON_HOME=$HOME/.virtualenvs
[ -f `brew --prefix`/share/python/virtualenvwrapper.sh ] && \
    source `brew --prefix`/share/python/virtualenvwrapper.sh

# bash prompt
case "$TERM" in
    xterm-color|xterm-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    #PS1='\[\033[00;31m\]\h\[\033[00m\] £ \[\033[01;34m\]\W\[\033[01;30m\]›\[\033[00m\] '
    PS1='\[\033[00;31m\]\h\[\033[00m\] £ \[\033[01;34m\]\w\n\[\033[01;30m\]›\[\033[00m\] '
else
    # Default is: PS1='\h:\W \u\$ '
    PS1='\h £ \w\n› '
fi

unset color_prompt

