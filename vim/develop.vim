set tabstop=4
set shiftwidth=4

" Отключаем перенос строк
setlocal nowrap

" Уровень сокрытия по умолчанию для вновь открытых файлов
setlocal foldlevelstart=0
" Метод фолдинга - по синтаксису
setlocal foldmethod=syntax

" Включаем отображение номеров строк
setlocal number

" Учитывать регистр букв при поиске
setlocal noignorecase

" Включить подсветку невидимых символов
setlocal list
" Настройка подсветки невидимых символов
setlocal listchars=tab:·\ ,trail:·
