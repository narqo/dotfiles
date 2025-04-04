# vim: ft=conf

# See https://no-color.org/
set -x NO_COLOR 1

# See https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
if [ (uname -s) = "Darwin" ];
    set -x XDG_CACHE_HOME $HOME/Library/Caches
else;
    set -x XDG_CACHE_HOME $HOME/.cache
end

# Some local XDG-like dirs
set -l confdir $XDG_CONFIG_HOME
set -l datadir $XDG_DATA_HOME

# Set up function paths
set fish_function_path $confdir/fish/functions $datadir/fish/functions $__fish_sysconf_dir/functions $__fish_data_dir/functions

# Clean up default fish greeting
set -gx fish_greeting ''

# Set up fisherman datadir
set -g fish_path $datadir/fish

# Set up colors
source $fish_path/conf.d/*.fish

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x EDITOR vim
set PATH $HOME/.local/bin /usr/local/bin /usr/local/sbin $PATH

# Don’t clear the screen after quitting a manual page
set -x MANPAGER "less -X"

# Go
set -x GOPATH $HOME/.local/lib/go
set -x GOBIN $HOME/.local/bin
set -x GOENV $XDG_CONFIG_HOME/go/env
set -x GOMODCACHE $XDG_CACHE_HOME/gomod

# Rust
set -x RUSTUP_HOME $HOME/.local/lib/rustup
set -x CARGO_HOME $HOME/.local/lib/cargo
set -x CARGO_INSTALL_ROOT $HOME/.local

set -x PATH $PATH $CARGO_HOME/bin

# Dart + Flutter
set -x PATH $PATH $HOME/.local/lib/flutter/bin

# Deno
set -x DENO_INSTALL_ROOT $HOME/.local/lib/deno/bin
set -x PATH $PATH $DENO_INSTALL_ROOT

# Bun
set -x BUN_CREATE_DIR $HOME/.local/share/bun/create

# Python
set -x PYTHONUSERBASE $HOME/.local

# Perl
set -x PERL5LIB $HOME/.local/lib/perl5
set -x PERL_LOCAL_LIB_ROOT $HOME/.local
set -x PERL_MB_OPT --install_base\ \"$HOME/.local\"
set -x PERL_MM_OPT "INSTALL_BASE=$HOME/.local"\ cpan\ local::lib

# Ruby
set -l gemdir (gem env --quiet gemdir 2> /dev/null)
if test -n "$gemdir"
    set PATH $PATH "$gemdir/bin"
end

# Docker Desktop (https://docs.docker.com/reference/cli/docker/compose/#set-up-environment-variables)
set -x COMPOSE_MENU false

set -x AZURE_CONFIG_DIR $XDG_CONFIG_HOME/azure
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x KUBECACHEDIR $XDG_CACHE_HOME

set -x PSQLRC $XDG_CONFIG_HOME/psqlrc
set -x PSPG_CONF $XDG_CONFIG_HOME/pspgconf

alias grep="grep --color"
alias tmux="tmux -2"
alias flushdns="dscacheutil -flushcache; and killall -HUP mDNSResponder"

if test (which eza 2> /dev/null)
    alias els=eza
    alias ell="eza -l --group-directories-first"
    alias ls=els
    alias ll=ell
end

if status --is-interactive
    abbr --add --global brw brew
    abbr --add --global gi git
    abbr --add --global ku kubectl
    abbr --add --global doco docker compose

    # should work natively (w/o on-event) in fish v4
    #function fish_should_add_to_history --on-event fish_postexec
    #    string match -qr "^(git br -(D|d|m))|(docker( image)? rm)" -- $argv;
    #    and history delete --exact --case-sensitive -- (string trim -r $argv);
    #end

    complete -f -c git-sw -a '(set -l t (commandline -ct); complete -C"git switch $t")'
end

# https://github.com/fish-shell/fish-shell/issues/11192 (should be fixed in 4.0.1)
set -Ua fish_features no-keyboard-protocols
