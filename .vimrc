" VIMRC - only for server use
" usecase: edit of config files

set noswapfile

set number
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set nowrap

set nohlsearch
set colorcolumn=90
set cursorline

let mapleader = " "

inoremap <c-e> <esc>
vnoremap <c-e> <esc>

nnoremap J j
nnoremap K k

vnoremap <silent> J :m '>+1<cr>gv=gv'
vnoremap <silent> K :m '<-2<cr>gv=gv'
vnoremap <silent> H <gv
vnoremap <silent> L >gv

nnoremap n nzz
nnoremap N Nzz

nnoremap j jzz
nnoremap k kzz
vnoremap j jzz
vnoremap k kzz
vnoremap J Jzz
vnoremap K Kzz

nnoremap <leader>a :Ex <cr>

highlight Normal ctermbg=235
highlight CursorLine cterm=None ctermbg=237
highlight! ColorColumn ctermbg=236

highlight! link Visual CursorLine

highlight NonText ctermfg=0
highlight LineNr ctermfg=242
highlight! CursorLineNr cterm=None ctermfg=141

highlight Comment ctermfg=239
highlight Statement ctermfg=141
highlight Special ctermfg=30
highlight PreProc ctermfg=30
