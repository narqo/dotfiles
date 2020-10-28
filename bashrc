# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd;exit:date"

# append to the history file, don't overwrite it
shopt -s histappend
# command name that is the name of a directory is executed as if it were the argument to the cd command
shopt -s autocd

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly
# See /usr/share/doc/bash-doc/examples in the bash-doc package

[ -r ~/.bash_aliases ] && \
    source ~/.bash_aliases

if [ ! -z "`which brew 2>/dev/null`" ]; then
    BREW_PREFIX=`brew --prefix 2>/dev/null`
    # Enable programmable completion features
    [ -f ${BREW_PREFIX}/etc/bash_completion ] && \
        source ${BREW_PREFIX}/etc/bash_completion

    [ -f ${BREW_PREFIX}/Library/Contributions/brew_bash_completion.sh ] && \
        source ${BREW_PREFIX}/Library/Contributions/brew_bash_completion.sh
fi

[ -r ~/.bash_completion ] && \
    source ~/.bash_completion

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e ~/.ssh/config ] && complete -o "default" -o "nospace" \
    -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

export EDITOR=vim

# Pip download cache directory path
export PIP_DOWNLOAD_CACHE=~/.cache/pip

# User's .psqlrc file
export PSQLRC=~/.config/psqlrc

# bash prompt
if [ -r ~/.bash_prompt ]; then
    source ~/.bash_prompt
else
    PS1="\h: ℐ𝓃 \w\n› "
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH=$HOME/.local/bin:$PATH
fi
