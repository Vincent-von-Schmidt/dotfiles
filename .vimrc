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

function <SID>close_tag(char)

    let currentLine = getline(".")
    let first = currentLine[col(".")-1]
    let second = currentLine[col(".")-1:col(".")]

    if a:char == ")"
        return first == ")" || second == " )" ? 1 : 0

    elseif a:char == "]"
        return first == "]" || second == " ]" ? 1 : 0

    elseif a:char == "}"
        return first == "}" || second == " }" ? 1 : 0

    endif
endfunction

function <SID>if_last_char()

    let lastChar = getline(".")[col(".")-2]
    return lastChar == "(" || lastChar == "[" || lastChar == "{" || lastChar == "\"" || lastChar == "\'" ? 1 : 0

endfunction

function <SID>if_last_and_next_char()
    
    let line = getline(".")

    let lastChar = line[col(".")-2]
    let nextChar = line[col(".")]

    let charCombo = lastChar.nextChar

    if charCombo == "()" || charCombo == "[]" || charCombo == "{}" || charCombo == "\"\"" || charCombo == "\'\'" || charCombo == "<space><space>"
        return 1
    else
        return 0
    endif

endfunction

inoremap <silent> ( ()<esc>i
inoremap <silent> [ []<esc>i
inoremap <silent> { {}<esc>i
inoremap <silent><expr> ) <SID>close_tag(")") ? "<esc>f)a" : ")"
inoremap <silent><expr> ] <SID>close_tag("]") ? "<esc>f]a" : "]"
inoremap <silent><expr> } <SID>close_tag("}") ? "<esc>f}a" : "}"
inoremap <silent><expr> " getline(".")[col(".")-1] == "\"" ? "<esc>f\"a" : "\"\"<esc>i"
inoremap <silent><expr> ' getline(".")[col(".")-1] == "'" ? "<esc>f'a" : "''<esc>i"
inoremap <silent><expr> <space> <SID>if_last_char() ? "<space><space><esc>i" : "<space>"
inoremap <silent><expr> <bs> <SID>if_last_and_next_char() ? "<esc>xxi" : "<bs>"

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
