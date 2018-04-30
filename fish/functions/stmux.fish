function stmux --wraps ssh --description 'SSH to tmux session'
    command ssh -t $argv 'tmux -CC -u attach-session || tmux -CC -u new-session'
end
