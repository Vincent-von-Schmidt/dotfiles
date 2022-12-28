-- bootstrap
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

-- init ---------------------------------------------------------

-- keymaps
local keymap = vim.keymap.set
local keymap_opts = { buffer = bufnr, silent = true, noremap = true }

-- leader key
keymap("", "<Space>", "<Nop>", opts)
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

-- plugins ------------------------------------------------------

require("lazy").setup({

    -- design ---------------------------------------------------

    {
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

    {
        "nanozuki/tabby.nvim",
        lazy = false,
        priority = 999,
        config = function()
            require("tabby.tabline").use_preset("tab_only", {
                nerdfont = true,
            })

            -- show tabline
            vim.o.showtabline = 2
        end,
    },

    {
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

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "c",
                    "cpp",
                    "rust",
                    "python",
                    "dart",
                    "markdown",
                    "bash",
                    "json"
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

    {
        "RRethy/vim-illuminate",
        lazy = false,
        config = function()
            require("illuminate").configure()
        end,
    },

    { -- indent lines
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },

    -- file browser ---------------------------------------------

    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        keys = {
            { "<leader>a", "<CMD> Telescope find_files <CR>", desc = "Telescope" },
            { "<leader>s", "<CMD> Telescope live_grep <CR>", desc = "LSP search" },
            { "<leader>lj", "<CMD> Telescope lsp_definitions <CR>", desc = "LSP jump" },
            { "<leader>ls", "<CMD> Telescope lsp_references <CR>", desc = "show information about hovered item" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "sharkdp/fd",
            "BurntSushi/ripgrep",
            "neovim/nvim-lspconfig",

            -- plugins
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-file-browser.nvim"
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
                            ["<leader>t"] = "select_tab",
                        },

                        -- normal
                        n = {
                            ["<leader>o"] = "select_vertical",
                            ["<leader>p"] = "select_horizontal",
                            ["<leader>t"] = "select_tab",
                        },
                    },
                },
                extensions = {
                    project = {
                        sync_with_nvim_tree = true,
                    },

                    file_browser = {
                        initial_mode = "normal",
                        hijack_netrw = true,
                    },
                },
            })

            telescope.load_extension("project")
            telescope.load_extension("file_browser")
        end,
    },

    -- lsp ------------------------------------------------------

    {
        "williamboman/mason.nvim",
        lazy = false,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "sumneko_lua", -- Lua
                    "clangd", -- C / C++
                    -- "csharp_ls", -- C#
                    "cmake", -- CMake
                    "cssls", -- CSS
                    "dockerls", -- Docker
                    "gradle_ls", -- Gradle
                    "html", -- html
                    -- "hls", -- Haskell
                    "jsonls", -- json
                    "jdtls", -- Java
                    "tsserver", -- JavaScript / TypeScript
                    "kotlin_language_server", -- Kotlin
                    "ltex", -- LaTeX
                    "marksman", -- Markdown
                    "intelephense", -- php
                    -- "powershell_es", -- Powershell
                    "bashls", -- bash
                    "pyright", -- Python
                    -- "r_language_server", -- R
                    "rust_analyzer", -- rust
                    "sqlls", -- sql
                    "taplo", -- TOML
                    "vimls", -- Vim
                    "lemminx", -- xml
                    "yamlls", -- yaml
                },
            })

            local lsp = require("lspconfig")
            lsp.sumneko_lua.setup{}
            lsp.clangd.setup{}
            -- lsp.csharp_ls.setup{}
            lsp.cmake.setup{}
            lsp.cssls.setup{}
            lsp.dockerls.setup{}
            lsp.gradle_ls.setup{}
            lsp.html.setup{}
            -- lsp.hls.setup{}
            lsp.jsonls.setup{}
            lsp.jdtls.setup{}
            lsp.tsserver.setup{}
            lsp.kotlin_language_server.setup{}
            lsp.ltex.setup{}
            lsp.marksman.setup{}
            lsp.intelephense.setup{}
            -- lsp.powershell_es.setup{}
            lsp.bashls.setup{}
            lsp.pyright.setup{}
            -- lsp.r_language_server.setup{}
            lsp.rust_analyzer.setup{}
            lsp.sqlls.setup{}
            lsp.taplo.setup{}
            lsp.vimls.setup{}
            lsp.lemminx.setup{}
            lsp.yamlls.setup{}
        end,
    },

    { -- flutter / dart
        "akinsho/flutter-tools.nvim",
        lazy = true,
        ft = "dart",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("flutter-tools").setup()
            require("telescope").load_extension("flutter")
        end,
    },

    -- windows --------------------------------------------------

    { --terminal
        "akinsho/toggleterm.nvim",
        lazy = false,
        config = function()
            if package.config:sub(1,1) == "/" then

                -- linux / mac
                require("toggleterm").setup({
                    size = 20,
                    start_in_insert = true,
                    direction = "horizontal",
                    insert_mappings = true,
                    shell = "zsh",
                    open_mapping = [[<C-t>]],
                })

            else

                -- windows
                require("toggleterm").setup({
                    size = 20,
                    start_in_insert = true,
                    direction = "horizontal",
                    insert_mappings = true,
                    shell = "wsl -d Ubuntu -e zsh",
                    open_mapping = [[<C-t>]],
                })

            end
        end,
    },

    { -- undotree
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "<leader>w", "<CMD> UndotreeToggle <CR> <CMD> UndotreeFocus <CR>", desc = "open undotree" },
        },
    },

    { -- outline
        "preservim/tagbar",
        lazy = true,
        keys = {
            { "<leader>e", "<CMD> TagbarToggle <CR>", desc = "open outline" },
        },
        config = function()
            if package.config:sub(1,1) == "/" then
                -- unix
                vim.g.tagbar_ctags_bin = "/snap/bin/universal-ctags"
            end
        end,
    },

    -- quality of life ------------------------------------------

    { -- intellisense
        "ms-jpq/coq_nvim",
        lazy = false,
        dependencies = {
            "ms-jpq/coq.artifacts"
        },
        config = function()
            vim.cmd("COQnow --shut-up")
            -- require("coq").setup()
        end,
    },

    { -- autopairs
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    { -- gcc -> comment / uncomment
        "terrortylor/nvim-comment",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim_comment").setup()
        end,
    },

    { -- surround -> ysiw) / ds) -> (word) / word
        "kylechui/nvim-surround",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    { -- zen mode
        "Pocco81/true-zen.nvim",
        lazy = true,
        keys = {
            { "<leader>z", "<CMD> TZAtaraxis <CR>", desc = "open true-zen mode" },
        },
        config = function()
            require("true-zen").setup()
        end,
    },
})

-- keymaps ------------------------------------------------------

-- auto center
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- tab
keymap("n", "<leader>tl", "<CMD> tabnext <CR>", opts)
keymap("n", "<leader>th", "<CMD> tabprevious <CR>", opts)
keymap("n", "<leader>tw", "<CMD> tabclose <CR>", opts)

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
