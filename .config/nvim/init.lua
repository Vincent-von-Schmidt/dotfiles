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

-- color mode
vim.opt.termguicolors = true

-- design
vim.opt.hlsearch = false
vim.opt.colorcolumn = "90"
vim.opt.cursorline = true
vim.o.showtabline = 0

-- keybinds - non plugin specific ------------------------------
local opts = { silent = true, noremap = true }
-- vim.env.key_opts = { silent = true, noremap = true }

-- leader
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- esc
vim.keymap.set("i", "<c-e>", "<esc>", opts)
vim.keymap.set("v", "<c-e>", "<esc>", opts)
vim.keymap.set("c", "<c-e>", "<esc>", opts)
vim.keymap.set("n", "<c-e>", "<esc>", opts)
vim.keymap.set("v", "<cr>", "<esc>", opts)

-- auto center
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "j", "jzz", opts)
vim.keymap.set("n", "k", "kzz", opts)
vim.keymap.set("v", "j", "jzz", opts)
vim.keymap.set("v", "k", "kzz", opts)
vim.keymap.set("v", "J", "Jzz", opts)
vim.keymap.set("v", "K", "Kzz", opts)

-- substitute highlighted word
vim.keymap.set("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

-- move highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gvzz", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gvzz", opts)
vim.keymap.set("v", "H", "<gv", opts)
vim.keymap.set("v", "L", ">gv", opts)

-- execute project
local execute_project_keymap = "<leader>r"

-- autocmd -----------------------------------------------------

-- python
local filetype_python = vim.api.nvim_create_augroup("python", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.py",
    group = filetype_python,
    callback = function()
        -- execute current python file
        vim.keymap.set(
            "n",
            execute_project_keymap,
            string.format(":vs term://python3 %s <CR>", vim.fn.expand("%")),
            opts
        )
    end,
})

-- rust
local filetype_rust = vim.api.nvim_create_augroup("rust", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.rs",
    group = filetype_rust,
    callback = function()
        -- execute current cargo project
        vim.keymap.set("n", execute_project_keymap, ":vs term://cargo run <CR>", opts)
    end,
})

-- haskell
local filetype_haskell = vim.api.nvim_create_augroup("haskell", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.hs",
    group = filetype_haskell,
    callback = function()
        -- open current file with ghci
        vim.keymap.set("n", execute_project_keymap, string.format(":vs term://ghci %s <CR>i", vim.fn.expand("%")), opts)
    end,
})

-- lua
local filetype_lua = vim.api.nvim_create_augroup("lua", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.lua",
    group = filetype_lua,
    callback = function()
        -- source current file in neovim
        vim.keymap.set("n", execute_project_keymap, ":so<CR>", opts)
    end,
})

-- c
local filetype_c = vim.api.nvim_create_augroup("c", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.c",
    group = filetype_c,
    callback = function()
        -- compile the current c file, run the binary and delete the binary
        vim.keymap.set(
            "n",
            execute_project_keymap,
            string.format(":vs term://gcc -o a.out %s && ./a.out && rm a.out <CR>", vim.fn.expand("%")),
            opts
        )
    end,
})

-- terminal ----------------------------------------------------

-- open new terminal bufffer in current working directory
-- temporary -> just a test -> TODO
-- vim.keymap.set("n", "<leader>o", ":vs term://zsh <CR>i", opts)
-- vim.keymap.set("n", "<leader>c", ":enew<CR>:terminal zsh<CR>i", opts)

local terminal = vim.api.nvim_create_augroup("term", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = terminal,
    callback = function()
        -- esc
        vim.keymap.set("t", "<c-e>", "<c-\\><c-n>", opts)
        vim.keymap.set("t", execute_project_keymap, "<c-\\><c-n>:bunload!<CR>", opts)

        -- close terminal buffer
        vim.keymap.set("n", execute_project_keymap, ":bunload! <CR>", opts)
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
