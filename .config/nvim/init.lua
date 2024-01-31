local vim_util = require("utils.vim")

-- editor ------------------------------------------------------

-- linenumbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- global clipboard
vim.o.clipboard = "unnamedplus"

-- spliting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- disable mouse
vim.cmd("set mouse = ")

-- backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.cmd([[
    if !isdirectory($HOME."/.vim")
        call mkdir($HOME."/.vim", "", 0770)
    endif
    if !isdirectory($HOME."/.vim/undodir")
        call mkdir($HOME."/.vim/undodir", "", 0700)
    endif

    set undodir=~/.vim/undodir
    set undofile
]])

-- sign column -> always on
vim.opt.signcolumn = "yes"

-- color mode
vim.opt.termguicolors = true

-- design
vim.opt.hlsearch = false
vim.opt.colorcolumn = "90"
vim.opt.cursorline = true
vim.o.showtabline = 0

-- keybinds - non plugin specific ------------------------------

-- leader
vim_util.keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- esc
vim_util.keymap("i", "<c-e>", "<esc>")
vim_util.keymap("v", "<c-e>", "<esc>")
vim_util.keymap("c", "<c-e>", "<esc>")
vim_util.keymap("n", "<c-e>", "<esc>")
vim_util.keymap("v", "<cr>", "<esc>")

-- auto center
vim_util.keymap("n", "n", "nzz")
vim_util.keymap("n", "N", "Nzz")
vim_util.keymap("n", "j", "jzz")
vim_util.keymap("n", "k", "kzz")
vim_util.keymap("n", "}", "}zz")
vim_util.keymap("n", "{", "{zz")
vim_util.keymap("v", "j", "jzz")
vim_util.keymap("v", "k", "kzz")
vim_util.keymap("v", "J", "Jzz")
vim_util.keymap("v", "K", "Kzz")
vim_util.keymap("v", "}", "}zz")
vim_util.keymap("v", "{", "{zz")

-- substitute highlighted word
vim_util.keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

-- move highlighted
vim_util.keymap("v", "J", ":m '>+1<CR>gv=gvzz")
vim_util.keymap("v", "K", ":m '<-2<CR>gv=gvzz")
vim_util.keymap("v", "H", "<gv")
vim_util.keymap("v", "L", ">gv")

-- command mode
vim_util.keymap("c", "<c-h>", "<left>", { noremap = true })
vim_util.keymap("c", "<c-l>", "<right>", { noremap = true })

-- execute project -> command needs to be defined in filetype autocmd
vim_util.keymap("n", "<leader>r", ":Run<CR>")

-- autocmd -----------------------------------------------------

local float_term = require("utils.floating_window").open_term

local misc = vim.api.nvim_create_augroup("misc", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "go to last edited position on opening file",
    group = misc,
    pattern = "*",
    command = 'silent! normal! g`"zvzz',
})

-- python
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "python",
    group = vim.api.nvim_create_augroup("python", { clear = true }),
    callback = function()
        -- execute current python file
        vim.api.nvim_create_user_command("Run", function()
            float_term("python3 " .. vim.fn.expand("%"))
        end, { force = true })
    end,
})

-- rust
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "rust",
    group = vim.api.nvim_create_augroup("rust", { clear = true }),
    callback = function()
        -- execute current cargo project
        vim.api.nvim_create_user_command("Run", function()
            float_term("cargo run")
        end, { force = true })
    end,
})

-- haskell
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "haskell",
    group = vim.api.nvim_create_augroup("haskell", { clear = true }),
    callback = function()
        -- open current file with ghci
        vim.api.nvim_create_user_command("Run", function()
            float_term("ghci " .. vim.fn.expand("%"))
        end, { force = true })
    end,
})

-- lua
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "lua",
    group = vim.api.nvim_create_augroup("lua", { clear = true }),
    callback = function()
        -- source current file in neovim
        vim.api.nvim_create_user_command("Run", "so", { force = true })
    end,
})

-- c
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "c",
    group = vim.api.nvim_create_augroup("c", { clear = true }),
    callback = function()
        -- compile the current c file, run the binary and delete the binary
        vim.api.nvim_create_user_command("Run", function()
            float_term("gcc -o a.out " .. vim.fn.expand("%") .. " && ./a.out && rm a.out")
        end, { force = true })
    end,
})

-- terminal ----------------------------------------------------

-- open new terminal bufffer in current working directory
-- temporary -> just a test -> TODO
-- vim_util.keymap("n", "<leader>o", ":vs term://zsh <CR>i")
-- vim_util.keymap("n", "<leader>c", ":enew<CR>:terminal zsh<CR>i")

local terminal = vim.api.nvim_create_augroup("term", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = terminal,
    callback = function()
        -- esc
        vim_util.keymap("t", "<c-e>", "<c-\\><c-n>")
        vim_util.keymap("t", execute_project_keymap, "<c-\\><c-n>:q!<CR>")

        -- close terminal buffer
        vim_util.keymap("n", execute_project_keymap, ":q! <CR>")
    end,
})

-- terminal mode
vim.api.nvim_create_autocmd({ "TermEnter" }, {
    group = terminal,
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.number = false
    end,
})

-- normal mode
vim.api.nvim_create_autocmd({ "TermLeave" }, {
    group = terminal,
    callback = function()
        vim.opt.relativenumber = true
        vim.opt.number = true
    end,
})

-- plugins -----------------------------------------------------

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim
require("lazy").setup("plugins")
