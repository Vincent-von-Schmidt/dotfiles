-- init ---------------------------------------------------------

-- bootstrap -> lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- highlight groups
function highlight(group, args)
    vim.api.nvim_set_hl(0, group, args)
end

-- keymaps
local keymap = vim.keymap.set
local keymap_opts = { buffer = bufnr, silent = true, noremap = true }

-- leader key
keymap("", "<Space>", "<Nop>", keymap_opts)
vim.g.mapleader = " "

-- editor -------------------------------------------------------

-- linenumbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop =  4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- wrap
vim.opt.wrap = false

-- clipboard -> global
vim.o.clipboard = "unnamedplus"

-- terminal colors
vim.opt.termguicolors = true

-- backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- language (only windows)
if package.config:sub(1,1) == "\\" then
    vim.cmd("language en_us")
end

-- design
vim.opt.hlsearch = false
vim.opt.colorcolumn = "90"
vim.opt.cursorline = true
vim.o.showtabline = 0

-- plugins ------------------------------------------------------

require("lazy").setup({

    -- design ---------------------------------------------------

    { -- main colorscheme
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()

            require("nightfox").setup({
                options = {
                    -- transparent background
                    transparent = false,
                },
            })
            vim.cmd("colorscheme carbonfox")

        end,
    },

    { -- statusline
        "ojroques/nvim-hardline",
        lazy = false,
        priority = 998,
        config = function()
            require("hardline").setup({
                theme = "dracula",
                section = {
                    {class = "mode", item = require("hardline.parts.mode").get_item},
                    {class = "med", item = require("hardline.parts.filename").get_item},
                    "%<",
                    {class = "med", item = "%="},
                    {class = "high", item = require("hardline.parts.filetype").get_item, hide = 60},
                    {class = "mode", item = require("hardline.parts.line").get_item}
                },
            })
        end,
    },

    { -- highlighting
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vim",
                    "regex",
                    "lua",
                    "python",
                    "markdown",
                    "bash",
                    "json",
                    "haskell",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    { -- sticky scrolling
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("treesitter-context").setup()

            highlight("TreesitterContext", { bg = "#1e1e1e" })
        end,
    },

    -- TODO -> complete hightlight, not just underlineing
    { -- hightlight same vars
        "RRethy/vim-illuminate",
        lazy = false,
        config = function()
            require("illuminate").configure()

            -- highlights
            highlight("illuminatedWordText", { bold = true, underline = true })
            highlight("illuminatedWordRead", { link = "illuminatedWordText" })
            highlight("illuminatedWordWrite", { link = "illuminatedWordText" })
        end,
    },

    { -- indent lines
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = false,
            })
        end,
    },

    { -- COMMAND ui
        "folke/noice.nvim",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("noice").setup({
                override = {
                    ["vim.lsp.util.convert_input_to_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
                views = {
                    cmdline_popup = {
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                        filter_options = {},
                    },
                },
                cmdline = {
                    enabled = true,
                    view = "cmdline",
                    -- view = "popup",
                    format = {
                        search_down = {
                            view = "cmdline",
                            -- view = "popup",
                        },
                        search_up = {
                            view = "cmdline",
                            -- view = "popup",
                        },
                    },
                },
            })

            require('notify').setup({
                background_colour = "#000000",
            })

            -- highlights
            highlight("NoiceCmdlinePopup", { link = "TelescopeNormal" })
            highlight("NoiceCmdlinePopupBorder", { link = "TelescopeBorder" })

        end,
    },

    -- file browser ---------------------------------------------

    -- TODO -> design
    { -- fzf finder
        "nvim-telescope/telescope.nvim",
        lazy = true,
        keys = {
            { "<leader>a", "<CMD> Telescope find_files <CR>" },
            { "<leader>s", "<CMD> Telescope live_grep <CR>" },
            { "<leader>q", "<CMD> Telescope file_browser <CR>" },
            { "<leader>c", "<CMD> Telescope project <CR>" },
            { "<leader>ld", "<CMD> Telescope lsp_definitions <CR>" },
            { "<leader>li", "<CMD> Telescope lsp_implementations theme=cursor <CR>" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "sharkdp/fd",
            "BurntSushi/ripgrep",

            -- plugins
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    mappings = {
                        -- insert
                        i = {
                            ["<leader>o"] = "select_vertical",
                            ["<leader>p"] = "select_horizontal",
                        },

                        -- normal
                        n = {
                            ["<leader>o"] = "select_vertical",
                            ["<leader>p"] = "select_horizontal",
                            ["K"] = "preview_scrolling_up",
                            ["J"] = "preview_scrolling_down",
                            ["<c-e>"] = "close",
                            ["<ESC>"] = "close",
                        },
                    },
                    -- design config
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },

                    file_browser = {
                        initial_mode = "normal",
                        hijack_netrw = true,
                        -- theme = "default",
                        hidden = true,
                    },
                },
            })

            telescope.load_extension("project")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")

            -- highlights
            highlight("TelescopeNormal", { bg = "#272f35" })
            highlight("TelescopePromptNormal", { bg = "#323a40" })

            highlight("TelescopeBorder", { fg = "#272f35", bg = "#272f35" })
            highlight("TelescopePromptBorder", { fg = "#323a40", bg = "#323a40" })

            highlight("TelescopeTitle", { link = "TelescopeBorder" })
            highlight("TelescopePromptTitle", { fg = "#2b3339", bg = "#e67e80" })
            highlight("TelescopePreviewTitle", { fg = "#2b3339", bg = "#83c092" })
        end,
    },

    -- language -------------------------------------------------

    { -- lsp
        "williamboman/mason.nvim",
        lazy = false,
        priority = 900, -- load after coq_nvim
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "ms-jpq/coq_nvim",
        },
        config = function()
            require("mason").setup({})

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", -- Python
                },
            })

            local coq = require("coq")
            local lsp = require("lspconfig")

            lsp.pyright.setup(coq.lsp_ensure_capabilities())

            -- keymaps
            keymap("n", "<leader>ls", vim.lsp.buf.hover, keymap_opts)

        end,
    },

    { -- LaTeX
        "lervag/vimtex",
        lazy = true,
        ft = { "tex", "plaintex", "latex", },
        dependencies = {
            "ms-jpq/coq.thirdparty",
        },
        config = function()
            -- editor
            vim.opt.wrap = true
            vim.opt.textwidth = 90

            -- add vimtex as coq source
            require("coq_3p") {
                { src = "vimtex", short_name = "vTEX" },
            }
        end,
    },


    -- quality of life ------------------------------------------

    { -- undotree
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "<leader>w", "<CMD> UndotreeToggle <CR> <CMD> UndotreeFocus <CR>" },
        },
    },

    { -- intellisense
        "ms-jpq/coq_nvim",
        lazy = false,
        priority = 950, -- load befor mason
        build = ":COQdeps",
        dependencies = {
            "ms-jpq/coq.artifacts",
            "ms-jpq/coq.thirdparty",
        },
        config = function()

            require("coq")

            vim.g.coq_settings = {
                ["clients.tabnine.enabled"] = false,
                ["keymap"] = {
                    ["recommended"] = false,
                    ["pre_select"] = true,
                    ["jump_to_mark"] = "<c-h>",
                    ["eval_snips"] = "<leader>h",
                },
                ["display"] = {
                    ["ghost_text.enabled"] = false,
                },
            }

            vim.cmd([[

                " init
                COQnow --shut-up

                " keymaps
                inoremap <silent><expr> <CR> pumvisible() ? "\<C-e><CR>" : "\<CR>"
                inoremap <silent><expr> <TAB> pumvisible() ? "\<C-e><TAB>" : "\<TAB>"
                inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-e><S-TAB>" : "\<S-TAB>"

            ]])

            -- keymaps
            -- keymap("i", "<c-h>", "<Nop>", keymap_opts)
            -- keymap("i", "<c-h>", "<ESC><c-h>", keymap_opts)

        end,
    },

    { -- auto-pairs
        "jiangmiao/auto-pairs",
        lazy = false,
    },

    { -- gcc -> comment / uncomment
        "terrortylor/nvim-comment",
        lazy = true,
        keys = { "gc" },
        config = function()
            require("nvim_comment").setup()
        end,
    },

    -- TODO -> visual
    { -- surround -> ysiw) / ds) -> (word) / word
        "kylechui/nvim-surround",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    { -- center code window
        "shortcuts/no-neck-pain.nvim",
        lazy = true,
        cmd = "NoNeckPain",
        keys = {
            { "<leader>z", "<CMD> NoNeckPain <CR>" },
        },
    },

    { -- file switcher
        "Vincent-von-Schmidt/harpoon",
        lazy = true,
        keys = {
            { "<leader>ta", "<CMD> lua require(\"harpoon.mark\").add_file() <CR>" },
            { "<leader>ti", "<CMD> lua require(\"harpoon.ui\").toggle_quick_menu() <CR>" },
            { "<leader>1", "<CMD> lua require(\"harpoon.ui\").nav_file(1) <CR>" },
            { "<leader>2", "<CMD> lua require(\"harpoon.ui\").nav_file(2) <CR>" },
            { "<leader>3", "<CMD> lua require(\"harpoon.ui\").nav_file(3) <CR>" },
            { "<leader>4", "<CMD> lua require(\"harpoon.ui\").nav_file(4) <CR>" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("harpoon")

            -- highlights
            highlight("HarpoonWindow", { link = "NormalFloat" })
            highlight("HarpoonBorder", { link = "TelescopeBorder" })
            highlight("HarpoonTitle", { link = "TelescopePromptTitle" })
        end,
    },

    { -- movement
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            require('leap').add_default_mappings()
        end,
    },

})

-- highlights ---------------------------------------------------
highlight("Normal", { bg = "#252525" })
highlight("NormalNC", { link = "Normal" })
highlight("NormalFloat", { bg = "#272f35" })
highlight("LazyNormal", { link = "NormalFloat" })

-- keymaps ------------------------------------------------------

-- esc
keymap("i", "<c-e>", "<ESC>", keymap_opts)
keymap("v", "<c-e>", "<ESC>", keymap_opts)
keymap("c", "<c-e>", "<ESC>", keymap_opts)
keymap("n", "<c-e>", "<ESC>", keymap_opts)

-- auto center
keymap("n", "n", "nzz", keymap_opts)
keymap("n", "N", "Nzz", keymap_opts)

keymap("n", "j", "jzz", keymap_opts)
keymap("n", "k", "kzz", keymap_opts)
keymap("v", "j", "jzz", keymap_opts)
keymap("v", "k", "kzz", keymap_opts)
keymap("v", "J", "Jzz", keymap_opts)
keymap("v", "K", "Kzz", keymap_opts)

-- visual mode quality of live
keymap("v", "<CR>", "<ESC>", keymap_opts)

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", keymap_opts)

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gvzz", keymap_opts)
keymap("v", "K", ":m '<-2<CR>gv=gvzz", keymap_opts)
keymap("v", "H", "<gv", keymap_opts)
keymap("v", "L", ">gv", keymap_opts)
