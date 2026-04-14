set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" This is broken in 0.12 https://github.com/neovim/neovim/issues/38987
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=

" TODO: what's that?
"autocmd VimLeave * set guicursor= | call nvim_ui_send("...")

noremap <C-q> :confirm qall<CR>
