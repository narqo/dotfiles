if status --is-interactive
    set PATH $PATH ~/bin ~/.local/bin ./node_modules/.bin
    set LANG=ru_RU.UTF-8
end

set -g -x fish_greeting ''

# colors
set -U fish_color_command ffd7ff
set -U fish_color_param ffd7ff
