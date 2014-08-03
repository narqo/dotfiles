# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then
    # GNU `ls`
    lscolorflag="--color"
else
    # OS X `ls`
    lscolorflag="-G"
fi

# enable color support for ls
alias ls="command ls $lscolorflag"
alias ll="ls -la $lscolorflag"

alias gti="git"

