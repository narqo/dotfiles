# vim: ft=conf

# Some local XDG-like dirs
set -l confdir ~/.config
set -l datadir ~/.local/share

# Set up function paths
set fish_function_path $confdir/fish/functions $datadir/fish/functions $__fish_sysconfdir/functions $__fish_datadir/functions

# Clean up default fish greeting
set -gx fish_greeting ''

# Set up colors
set -g fish_color_command ffd7ff
set -g fish_color_param ffd7ff

if status --is-login
    set -gx LANG en_US.UTF-8
end

if status --is-interactive
    set EDITOR vim
    set PATH ./node_modules/.bin ~/.local/bin ~/bin /usr/local/bin $PATH
end
