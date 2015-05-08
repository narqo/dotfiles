# vim: ft=conf

# Some local XDG-like dirs
set -l confdir $HOME/.config
set -l datadir $HOME/.local/share

# Set up function paths
set fish_function_path $confdir/fish/functions $datadir/fish/functions $__fish_sysconfdir/functions $__fish_datadir/functions

# Clean up default fish greeting
set -gx fish_greeting ''

# Set up colors (reset default colours)
set -g fish_color_command
set -g fish_color_param

if status --is-login
    set -x LANG en_US.UTF-8
end

if status --is-interactive
    set -x EDITOR vim
    set -x PATH ./node_modules/.bin $HOME/.local/bin /usr/local/bin $PATH
end
