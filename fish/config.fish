# vim: ft=conf

# See https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

# Some local XDG-like dirs
set -l confdir $XDG_CONFIG_HOME
set -l datadir $XDG_DATA_HOME

# Set up function paths
set fish_function_path $confdir/fish/functions $datadir/fish/functions $__fish_sysconf_dir/functions $__fish_data_dir/functions

# Clean up default fish greeting
set -gx fish_greeting ''

# Set up fisherman datadir
set -g fish_path $datadir/fish

# Set up colors (reset default colours)
set -g fish_color_command
set -g fish_color_param

if status --is-login
    set -x LC_ALL en_US.UTF-8
    set -x LANG en_US.UTF-8
end

if status --is-interactive
    set -x EDITOR vim
    set PATH $HOME/.local/bin /usr/local/bin $PATH
end

# Don’t clear the screen after quitting a manual page
set -x MANPAGER "less -X"

set -x PYTHONUSERBASE $HOME/.local
set -x GOPATH $HOME/.local/lib/go

set -x RUSTUP_HOME $HOME/.local/lib/rustup
set -x CARGO_HOME $HOME/.local/lib/cargo

set -x PATH $PATH $CARGO_HOME/bin

set -x PATH $PATH $HOME/.local/lib/flutter/bin

set -x PERL5LIB $HOME/.local/lib/perl5
set -x PERL_LOCAL_LIB_ROOT $HOME/.local
set -x PERL_MB_OPT --install_base\ \"$HOME/.local\"
set -x PERL_MM_OPT "INSTALL_BASE=$HOME/.local"\ cpan\ local::lib

set -l gemdir (gem env --quiet gemdir 2> /dev/null)
if test -n "$gemdir"
    set PATH $PATH "$gemdir/bin"
end

alias grep="grep --color"
alias tmux="tmux -2"
alias flushdns="dscacheutil -flushcache; and killall -HUP mDNSResponder"

if status --is-interactive
    abbr --add --global brw brew
    abbr --add --global gi git
end
