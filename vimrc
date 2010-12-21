" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype on
syntax on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

set wildmenu

set cursorline
set number

" Show the cursor position all the time
set ruler

" Jump 7 lines when running out of the screen
set scrolljump=7

" Indicate jump out of the screen when 10 lines before end of the screen
set scrolloff=7

" Turn off any bells
set novisualbell
set t_vb=

" Fix <Enter> for comment
set fo+=cr

" Выключаем перенос строк
set nowrap
set nolinebreak

" Отборажение текущей комманды
set showcmd

" Включаем отображение дополнительной информации в статусной строке
set laststatus=2
"set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P
set statusline=%f\ %m\ %r\ %{&encoding}\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]


""" ПОИСК
" Включаем подсветку выражения, которое ищется в тексте
set hlsearch
" При поиске перескакивать на найденный текст в процессе набора строки
set incsearch
" Останавливать поиск при достижении конца файла
set nowrapscan
" Игнорировать регистр букв при поиске
set ignorecase


""" BACKUP
" Отключаем создание бэкапов
set nobackup
" Отключаем создание swap файлов
set noswapfile
"" Все swap файлы будут помещаться в эту папку
"set dir=~/.vim/swp

"" Размер истории для отмены
set undolevels=50

" Кодировка по-умолчанию
set termencoding=utf-8
" Список кодировок файлов для автоопределения
set fileencodings=utf-8,cp1251,koi8-r,cp866

" Метод фолдинга - вручную (для обычных файлов)
"set foldmethod=manual
" Уровень сокрытия по умолчанию для вновь открытых файлов
setlocal foldlevelstart=0
" Метод фолдинга - по синтаксису
setlocal foldmethod=syntax


""" DIFF
" Add ignorance of whitespace to diff
set diffopt+=iwhite


""" KEY MAPS
" Очистить подсветку последнего найденного выражения
nmap <F3> :nohlsearch<CR>
imap <F3> <Esc>:nohlsearch<CR>
vmap <F3> <Esc>:nohlsearch<CR>gv

" More suitable mapping
function SMap(key, action, ...)
  let modes = " vi"
  if (a:0 > 0)
	  let modes = a:{1}
  endif
  if (match(modes, '\Ii') != -1)
	  execute 'imap ' . a:key . ' <Esc>' . a:action
  endif
  if (match(modes, '\Nn') != -1)
	  execute 'nmap ' . a:key . ' <Esc>' . a:action
  endif
  if (match(modes, ' ') != -1)
	  execute 'map ' . a:key . ' <Esc>' . a:action
  endif
  if (match(modes, '\Vv') != -1)
	  execute 'vmap ' . a:key . ' <Esc>' . a:action
  endif
endfunction

" C-T - new tab
"call SMap("<C-t>", ":tabnew<cr>")

" Дублировать строку после текущей
map <C-A-up> <esc>yyPi
" Дублировать строку перед текущей
map <C-A-down> <esc>yypi

" Auto compleate
imap <C-space> <C-x><C-o>

" Удалить строку
imap <C-d> <esc>ddi

" Starts new line
imap <S-cr> <esc>o
imap <C-S-cr> <esc>O

vmap <C-C> "+yi
imap <C-V> <esc>"+gPi

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh


"-------------------------
" GUI
"-------------------------
set background=light

" Konsole-256color fix
set t_Co=256
colorscheme xoria256
"colorscheme delek

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175


"-------------------------
" NERD Tree
"-------------------------
" Toggle the NERD Tree on an off with F6
nmap <F6> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F6
nmap <S-F6> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=['\.pyc$', '\~$']


"-------------------------
" LaTeX
"-------------------------

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


" XML/HTML tags aut complition map
let xml_tag_completion_map = "></"
