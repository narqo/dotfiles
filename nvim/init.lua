vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.o.runtimepath

vim.opt.guicursor = ''

vim.cmd('source ~/.vim/vimrc')

vim.keymap.set('n', '<C-q>', ':confirm qall<CR>')
