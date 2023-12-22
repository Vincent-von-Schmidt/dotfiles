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
vim.opt.undofile = true

-- design
vim.opt.hlsearch = false
vim.opt.colorcolumn = "90"
vim.opt.cursorline = true
vim.o.showtabline = 0

-- keybinds - non plugin specific ------------------------------
local keymap = vim.keymap.set
local default_args = { silent = true, noremap = true }

-- leader
keymap("", "<Space>", "<Nop>", default_args)
vim.g.mapleader = " "

-- esc
keymap("i", "<c-e>", "<esc>", default_args)
keymap("v", "<c-e>", "<esc>", default_args)
keymap("c", "<c-e>", "<esc>", default_args)
keymap("n", "<c-e>", "<esc>", default_args)
keymap("v", "<cr>", "<esc>", default_args)

-- auto center
keymap("n", "n", "nzz", default_args)
keymap("n", "N", "Nzz", default_args)
keymap("n", "j", "jzz", default_args)
keymap("n", "k", "kzz", default_args)
keymap("v", "j", "jzz", default_args)
keymap("v", "k", "kzz", default_args)
keymap("v", "J", "Jzz", default_args)
keymap("v", "K", "Kzz", default_args)

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gvzz", default_args)
keymap("v", "K", ":m '<-2<CR>gv=gvzz", default_args)
keymap("v", "H", "<gv", default_args)
keymap("v", "L", ">gv", default_args)

-- highlight groups --------------------------------------------
function highlight(group, args)
    vim.api.nvim_set_hl(0, group, args)
end

highlight("Normal", { bg = "None" })
highlight("NormalNC", { link = "Normal" })

highlight("CursorLine", { bg = "#3a3a3a" })
highlight("Visual", { link = "CursorLine" })

highlight("NonText", { fg = "#000000" })

highlight("LineNr", { fg = "#6c6c6c" })
highlight("CursorLineNr", { fg = "#af87ff" })

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
