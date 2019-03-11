function goclone --description 'Clone a go package'
    set -l __pkg (echo -n $argv | sed 's!^http[s]\?://!! ; s!^git@!! ; s!.git$!!' | tr ':' '/')
    set -l __gopath (go env GOPATH | awk -F: '{print $NF}')
    git clone $argv $__gopath/src/$__pkg
end
