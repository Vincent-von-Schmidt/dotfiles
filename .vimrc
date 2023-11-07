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

"-- Esc rebinds --------------------------------------------

inoremap <c-e> <Esc>
vnoremap <c-e> <Esc>

"-- visual mode --------------------------------------------

vnoremap <cr> <Esc>
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
    let charCombo = line[col(".")-2].line[col(".")-1]

    return charCombo == "()" || charCombo == "[]" || charCombo == "{}" || charCombo == "\"\"" || charCombo == "\'\'" ? 1 : 0 

endfunction

inoremap <silent> ( ()<Esc>i
inoremap <silent> [ []<Esc>i
inoremap <silent> { {}<Esc>i
inoremap <silent><expr> ) <SID>close_tag(")") ? "<Esc>f)a" : ")"
inoremap <silent><expr> ] <SID>close_tag("]") ? "<Esc>f]a" : "]"
inoremap <silent><expr> } <SID>close_tag("}") ? "<Esc>f}a" : "}"
inoremap <silent><expr> " getline(".")[col(".")-1] == "\"" ? "<Esc>f\"a" : "\"\"<Esc>i"
inoremap <silent><expr> ' getline(".")[col(".")-1] == "'" ? "<Esc>f'a" : "''<Esc>i"
inoremap <silent><expr> <Space> <SID>if_last_char() ? "<Space><Space><Esc>i" : "<Space>"
inoremap <silent><expr> <BS> <SID>if_last_and_next_char() ? "<Esc>xxi" : "<BS>"

"-- surround -----------------------------------------------

" nnoremap <silent><expr> ysiw) ":%s/".expand("<cword>")."/(".expand("<cword>").")/gI<cr>"
" nnoremap <silent><expr> ysiw) ":%s/".expand("<cword>")."/(".expand("<cword>")."/gI<cr>"
" nnoremap <silent> ysiw( :%s/\<<c-r><c-w>\>/( <c-r><c-w> )/gI<cr>
" vnoremap <silent> S) :'<,'>s/\<<c-r><c-w>\>/(<c-r><c-w>)/gI

" substitute highlighted word
nnoremap <leader>g :%s/\<<c-r><c-w>\>/<c-r><c-w>/gI<Left><Left><Left>

" open explorer - leader a
nnoremap <leader>q :Ex <cr>

"-- general highlightgroups --------------------------------

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
highlight! String ctermfg=35
highlight! link Character String
highlight! Number ctermfg=80
highlight! link Float Number
highlight! link Boolean Number

highlight! SpecialHighlight ctermfg=250
syntax match SpecialHighlight /\[/
syntax match SpecialHighlight /\]/
syntax match SpecialHighlight /(/
syntax match SpecialHighlight /)/
syntax match SpecialHighlight /\:/
syntax match SpecialHighlight /\./
syntax match SpecialHighlight /\,/

" imports
highlight PreProc ctermfg=161

" color conected tag
highlight! MatchParen ctermbg=None ctermfg=221

" todo highlight
" highlight! SpecialComment ctermbg=100
" syntax match SpecialComment /.*TODO.*/

"-- comment ------------------------------------------------ 

function <SID>tt()
    let line = getline(".")
    execute ":.s/".line."/# ".line."/g <cr>"
endfunction

nnoremap <silent><exec> tt <SID>tt()

function! <SID>Comment(type)

    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0
        silent execute "normal! ´< ". a:type . "´>y"
    endif

    let &selection = sel_save
    let @@ = reg_save

endfunction

function <SID>Test(char)

    let type = a:char
    let pos = getpos(".")[2]
    let position = pos == 0 ? 0 : pos-1
    execute "normal! I# "
    execute "0 ".position."l"

endfunction

nnoremap <c-b> :set operatorfunc=<SID>Comment@g<cr>

"-- per file type ------------------------------------------

" python ---------------------
augroup filetype_python
    autocmd!

    autocmd FileType python nnoremap <silent> gcc mqI# \<esc>`q

    " press F5 to run current open file with python3
    autocmd FileType python nnoremap <silent><expr> <F5> ":!python3 ".expand("%")."<cr>"

    " comment -> TODO
    "  autocmd FileType python nnoremap gc :set opfunc=<SID>Test<cr>g@
    autocmd FileType python nnoremap gcc :call <SID>Test("#")<cr>
    autocmd FileType python nnoremap <expr> bb "I# <esc>0".(getpos(".")[2]-1)."l"

    autocmd FileType python highlight! link SpecialStatement PreProc
    autocmd FileType python syntax keyword SpecialStatement self cls

    autocmd FileType python highlight! link PythonSpecialLogicalGate SpecialHighlight
    autocmd FileType python syntax keyword PythonSpecialLogicalGate and or

    autocmd FileType python highlight! link SpecialState Number
    autocmd FileType python syntax keyword SpecialState None True False

    autocmd FileType python highlight! DoubleUnderScore ctermfg=40
    autocmd FileType python syntax match DoubleUnderScore /__*__/

augroup END

" latex ----------------------
augroup filetype_tex
    autocmd!

    " press F5 to compile the file with pdflatex
    autocmd FileType tex nnoremap <silent><expr> <F5> ":!pdflatex ".expand("%")."<cr>"

augroup END

" haskell --------------------
augroup filetype_haskell
    autocmd!
    
    " open file with ghci
    autocmd FileType haskell nnoremap <silent><expr> <F5> ":!ghci ".expand("%")."<cr>"

augroup END

"-- debug --------------------------------------------------

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

nnoremap <leader>t :call SynGroup() <cr>
