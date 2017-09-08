function goget --description 'Get Go package'
    set -l __gopath (go env GOPATH | awk -F: '{print $NF}')
    command env GOPATH=$__gopath go get -u -d -v $argv
end

