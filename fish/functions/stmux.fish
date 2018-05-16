function stmux --wraps ssh --description 'SSH to tmux session'
    command ssh -t $argv 'tmux -CC -2 -u attach-session || tmux -CC -2 -u new-session'
end
