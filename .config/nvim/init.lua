local float = require("utils.float")

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

-- wrapping
vim.opt.wrap = false

-- global clipboard
vim.o.clipboard = "unnamedplus"

-- spliting
-- vim.opt.splitbelow = true
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
vim.keymap.set("", "<SPACE>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "

-- esc
vim.keymap.set("n", "<c-e>", "<ESC>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-e>", "<ESC>", { silent = true, noremap = true })
vim.keymap.set("v", "<c-e>", "<ESC>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-e>", "<ESC>", { silent = true, noremap = true })
vim.keymap.set("s", "<c-e>", "<ESC>", { silent = true, noremap = true })
vim.keymap.set("v", "<cr>", "<ESC>", { silent = true, noremap = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = vim.api.nvim_create_augroup("after_dashboard", { clear = true }),
    callback = function()
        -- auto center
        vim.keymap.set("n", "n", "nzz", { silent = true, noremap = true })
        vim.keymap.set("n", "N", "Nzz", { silent = true, noremap = true })
        vim.keymap.set("n", "j", "jzz", { silent = true, noremap = true })
        vim.keymap.set("n", "k", "kzz", { silent = true, noremap = true })
        vim.keymap.set("n", "}", "}zz", { silent = true, noremap = true })
        vim.keymap.set("n", "{", "{zz", { silent = true, noremap = true })
        vim.keymap.set("v", "j", "jzz", { silent = true, noremap = true })
        vim.keymap.set("v", "k", "kzz", { silent = true, noremap = true })
        vim.keymap.set("v", "J", "Jzz", { silent = true, noremap = true })
        vim.keymap.set("v", "K", "Kzz", { silent = true, noremap = true })
        vim.keymap.set("v", "}", "}zz", { silent = true, noremap = true })
        vim.keymap.set("v", "{", "{zz", { silent = true, noremap = true })

        -- substitute highlighted word
        vim.keymap.set("n", "<leader>gf", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })
        vim.keymap.set("n", "<leader>gl", ":.s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

        -- move highlighted
        vim.keymap.set("v", "J", ":m '>+1<CR>gv=gvzz", { silent = true, noremap = true })
        vim.keymap.set("v", "K", ":m '<-2<CR>gv=gvzz", { silent = true, noremap = true })
        vim.keymap.set("v", "H", "<gv", { silent = true, noremap = true })
        vim.keymap.set("v", "L", ">gv", { silent = true, noremap = true })
    end,
})

-- command mode
vim.keymap.set("c", "<c-h>", "<left>", { noremap = true })
vim.keymap.set("c", "<c-l>", "<right>", { noremap = true })

-- execute project -> command needs to be defined in filetype autocmd
vim.keymap.set("n", "<leader>r", ":Run<CR>", { silent = true, noremap = true })

-- autocmd -----------------------------------------------------

local misc = vim.api.nvim_create_augroup("misc", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    desc = "go to last edited position on opening file",
    group = misc,
    pattern = "*",
    command = 'silent! normal! g`"zvzz',
})

-- python
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "python",
    group = vim.api.nvim_create_augroup("python", { clear = true }),
    callback = function()
        -- execute current python file
        vim.api.nvim_create_user_command("Run", function()
            float.term("python3 " .. vim.fn.expand("%"))
        end, { force = true })
    end,
})

-- rust
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "rust",
    group = vim.api.nvim_create_augroup("rust", { clear = true }),
    callback = function()
        -- execute current cargo project
        vim.api.nvim_create_user_command("Run", function()
            float.term("cargo run")
        end, { force = true })
    end,
})

-- haskell
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "haskell",
    group = vim.api.nvim_create_augroup("haskell", { clear = true }),
    callback = function()
        -- open current file with ghci
        vim.api.nvim_create_user_command("Run", function()
            float.term("ghci " .. vim.fn.expand("%"))
        end, { force = true })
    end,
})

-- lua
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "lua",
    group = vim.api.nvim_create_augroup("lua", { clear = true }),
    callback = function()
        -- source current file in neovim
        vim.api.nvim_create_user_command("Run", "so", { force = true })
    end,
})

-- c
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "c",
    group = vim.api.nvim_create_augroup("c", { clear = true }),
    callback = function()
        -- compile the current c file, run the binary and delete the binary
        vim.api.nvim_create_user_command("Run", function()
            float.term("gcc -o a.out " .. vim.fn.expand("%") .. " && ./a.out && rm a.out")
        end, { force = true })
    end,
})

-- latex
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = { "tex", "plaintex" },
    group = vim.api.nvim_create_augroup("latex", { clear = true }),
    callback = function()
        -- compile current latex file with pdflatex
        vim.api.nvim_create_user_command("Run", function()
            float.term("pdflatex " .. vim.fn.expand("%"))
        end, { force = true })

        vim.cmd([[

            set textwidth=0
            set wrapmargin=0
            set wrap
            set linebreak
            set columns=90

            set spell

        ]])
    end,
})

-- markdown
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
    pattern = "markdown",
    group = vim.api.nvim_create_augroup("markdown", { clear = true }),
    callback = function()
        vim.cmd([[

            set spell

        ]])
    end,
})

-- terminal ----------------------------------------------------

local terminal = vim.api.nvim_create_augroup("term", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = terminal,
    callback = function()
        -- esc
        vim.keymap.set("t", "<c-e>", "<c-\\><c-n>", { silent = true, noremap = true })
        -- TODO
        vim.keymap.set("t", "<c-x>", "<c-\\><c-n>:q!<CR>", { silent = true, noremap = true })

        vim.cmd("startinsert")
    end,
})

-- terminal mode
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = terminal,
    callback = function()
        vim.cmd([[

            setlocal nonumber
            setlocal norelativenumber

        ]])
    end,
})

-- -- normal mode
-- vim.api.nvim_create_autocmd({ "TermClose" }, {
--     group = terminal,
--     callback = function()
--         vim.opt.relativenumber = true
--         vim.opt.number = true
--     end,
-- })

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
require("lazy").setup("plugins", {
    install = {
        missing = false,
        colorscheme = { "rose-pine" },
    },
    dev = {
        path = "/mnt/c/Users/Vincent/Documents/code/neovim/",
    },
})

-- gui ---------------------------------------------------------

-- for wsl passthrough to windows
if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.7
    vim.api.nvim_set_hl(0, "Normal", { bg = "#262626" })
    vim.cmd("set mouse=a")
end
