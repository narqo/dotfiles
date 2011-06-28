"set t_Co=256
"colorscheme xoria256
set background=dark
colorscheme solarized

" Make command line two lines high
set ch=2

set lines=60
set columns=150

set gfn=Monaco:h13

"" GUI Settings
" Don't show toolbar                                                                                                                             
set guioptions-=T                                                                                                                                
" Don't show scrolbars                                                                                                                           
set guioptions-=L                                                                                                                                
set guioptions-=r                                                                                                                                
" Use console dialogs for simple choices                                                                                                         
set guioptions+=c 

"" MACVIM SETTINGS
if has("gui_macvim")
  set transp=0
  set formatoptions-=tc
  let macvim_hig_shift_movement = 1
endif

