execute pathogen#infect()
syntax enable
filetype plugin indent on

let g:solarized_termcolors=256
let g:airline_theme = "solarized"
let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1

colorscheme solarized

" Keymappings
call togglebg#map("<F5>")
":nmap <C-N> <Esc>:set invnumber<CR>
nnoremap <C-N> :set invnumber<CR>
inoremap <C-N> <Esc>:set invnumber<CR>
map <F2> <Esc>:set paste<CR>i
map <F3> <Esc>:set nopaste<CR>
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Various settings
set nomodeline
set nobackup
set mouse=a
set backspace=indent,eol,start
set hlsearch
set incsearch
set cursorline

" Indentation
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
