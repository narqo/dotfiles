vim.opt.runtimepath:prepend('~/.vim')
vim.opt.runtimepath:append('~/.vim/after')
vim.opt.packpath = vim.o.runtimepath

vim.opt.guicursor = ''

vim.cmd('source ~/.vim/vimrc')

vim.pack.add({ 'https://github.com/narqo/review-comments.nvim' })

vim.keymap.set('n', '<C-q>', ':confirm qall<CR>')
