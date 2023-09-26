" VIMRC - only for server use
" usecase: edit of config files and Vallies config file

" undo
set noswapfile
set nobackup
set undofile

" linenumbers
set number
set relativenumber

" tabs as 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" line behavior
set nowrap

" visual search behavior
set nohlsearch

" visual position
set colorcolumn=90
set cursorline

" leader key - like ctrl or alt
let mapleader = " "

"-- esc rebinds --------------------------------------------

inoremap <c-e> <esc>
vnoremap <c-e> <esc>

"-- visual mode --------------------------------------------

vnoremap <cr> <esc>
nnoremap <m-v> <c-v>

" shift highlighted lines
vnoremap <silent> J :m '>+1<cr>gv=gv'
vnoremap <silent> K :m '<-2<cr>gv=gv'
vnoremap <silent> H <gv
vnoremap <silent> L >gv

"-- view always centerd ------------------------------------

" search
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" general movement
nnoremap <silent> j jzz
nnoremap <silent> k kzz
vnoremap <silent> j jzz
vnoremap <silent> k kzz
vnoremap <silent> J Jzz
vnoremap <silent> K Kzz

"-- auto closing tag ---------------------------------------

function CloseTag(char)

    let currentLine = getline(".")
    let first = currentLine[col(".")-1]
    let second = currentLine[col(".")-1:col(".")]

    if a:char == ")"
        return first == ")" || second == " )" ? "<esc>f)a" : ")"
        " execute first == ")" || second == " )" ? "<esc>f)a" : ")"

    elseif a:char == "]"
        return first == "]" || second == " ]" ? "<esc>f]a" : "]"
        " execute first == "]" || second == " ]" ? "<esc>f]a" : "]"

    elseif a:char == "}"
        return first == "}" || second == " }" ? "<esc>f}a" : "}"
        " execute first == "}" || second == " }" ? "<esc>f}a" : "}"

    endif

endfunction

inoremap <silent> ( ()<esc>i
inoremap <silent> [ []<esc>i
inoremap <silent> { {}<esc>i
inoremap <silent><expr> ) CloseTag(")")
inoremap <silent><expr> ] CloseTag("]")
inoremap <silent><expr> } CloseTag("}")
inoremap <silent><expr> " getline(".")[col(".")-1] == "\"" ? "<esc>f\"a" : "\"\"<esc>i"
inoremap <silent><expr> ' getline(".")[col(".")-1] == "'" ? "<esc>f'a" : "''<esc>i"
inoremap <silent><expr> <space> getline(".")[col(".")-2] == "(" ? "<space><space><esc>i" : "<space>"

"-- surround -----------------------------------------------

function Test()
    echo expand("<cword>")
endfunction

nnoremap <silent><expr> ysiw) ":%s/".expand("<cword>")."/(".expand("<cword>").")/gI<cr>"
" nnoremap <silent><expr> ysiw) ":%s/".expand("<cword>")."/(".expand("<cword>")."/gI<cr>"
nnoremap <silent> ysiw( :%s/\<<c-r><c-w>\>/( <c-r><c-w> )/gI<cr>
" vnoremap <silent> S) :'<,'>s/\<<c-r><c-w>\>/(<c-r><c-w>)/gI

"-- run python3 script -------------------------------------
nnoremap <silent><expr> <F5> "!python3" . expand("%")

" substitute highlighted word
nnoremap <leader>g :%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<Left><Left><Left>

" open explorer - leader a
nnoremap <leader>q :Ex <cr>

"-- design -------------------------------------------------

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

highlight! MatchParen ctermbg=None ctermfg=221
