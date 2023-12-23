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

-- color mode
vim.opt.termguicolors = true

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
]])
vim.opt.undodir = "$HOME/.vim/undodir"
vim.opt.undofile = true

-- design
vim.opt.hlsearch = false
vim.opt.colorcolumn = "90"
vim.opt.cursorline = true
vim.o.showtabline = 0

-- keybinds - non plugin specific ------------------------------
local opts = { silent = true, noremap = true }

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
