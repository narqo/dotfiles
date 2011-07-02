" Настройки табов для Python, согласно рекоммендациям
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "ставим табы пробелами
set softtabstop=4 "4 пробела в табе

" Подсвечиваем рекомендуемую длинну строки 
setlocal textwidth=80
setlocal colorcolumn=+1 

" Автоотступ
set autoindent

" Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1

" Ключевые слова, по которым smartindent будет расставлять отступы
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

" Чтобы из-за smartindent'а при написании комментария в пустой
" строке курсор не переносился в начало строки
inoremap # X<C-H>#

" Настройка omnicomletion для Python
autocmd FileType python set omnifunc=pythoncomplete#Complete
