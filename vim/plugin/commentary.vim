" Maintainer:   Marc Weber <marco-oweberNOSPAM@gmx.de>
" original auhtor: Tim Pope

" vam#DefineAndBind('g:commentary','s:c','{}')
if !exists('s:c') | let s:c = {} | endif | let g:commentary = s:c
let s:c['default_options'] = function('commentary#DefaultOptions')

" visual/selection mode commenting/uncommenting
xnoremap <silent> \\  <c-v>:<C-U>call commentary#CommentLineRange(line("'<"), line("'>"), 'auto')<CR>
                    " ^ <c-v> makes vim return col('.') correctly. Then comments are inserted at col
                    " of cursor (or first non whitespace char)

" movement \\
nnoremap <silent> \\  :<C-U>set opfunc=commentary#GoMove<CR>g@
" n\\\ will comment n lines. Having repeat#set will allow you repeating this
" \\\ action with . Not having it will show an error which doesn't hurt much
nnoremap <silent> \\\ :<C-U>call commentary#CommentLineRange(line("."), line(".") + v:count1 - 1, 'auto')
                      \ <bar>call repeat#set('\\\',v:count1)<CR>

" if you want to force commenting/ uncommenting create your own mappings
" replacing 'auto' by 'comment' or 'uncomment'

" if this plugin is is no feature complete try tcomment or NerdCommenter or
" any of the various other existing completion scripts

" vim:set sw=2 sts=2:
