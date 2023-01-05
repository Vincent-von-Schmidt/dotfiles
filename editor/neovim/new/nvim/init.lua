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
                    transparent = true,
                },
            })
            vim.cmd("colorscheme carbonfox")
        end,
    },

    -- TODO
    { -- vscode colorscheme
        "Mofiqul/vscode.nvim",
        lazy = true,
        cmd = {
            "Telescope colorscheme",
            "Coloscheme vscode",
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            -- dark theme
            vim.o.background = "dark"

            local vscolors = require("vscode.colors")
            require("vscode").setup({
                -- background
                transparent = false,

                -- italic comments
                italic_comments = false,

                -- color override
                color_overrides = {
                    vscLineNumber = "#FFFFFF",
                },

                group_overrides = {
                    Cursor = {
                        fg = vscolors.vscDarkBlue,
                        bg = vscolors.vscLightGreen,
                        bold = true
                    },
                },
            })
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
                    "lua",
                    "c",
                    "cpp",
                    "rust",
                    "python",
                    "dart",
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

    -- TODO -> complete hightlight, not just underlineing
    { -- hightlight same vars
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
                show_current_context_start = false,
            })
        end,
    },

    -- file browser ---------------------------------------------

    -- TODO -> design
    { -- fzf finder
        "nvim-telescope/telescope.nvim",
        lazy = true,
        keys = {
            { "<leader>a", "<CMD> Telescope find_files <CR>", desc = "Telescope" },
            { "<leader>s", "<CMD> Telescope live_grep <CR>", desc = "LSP search" },
            { "<leader>q", "<CMD> Telescope file_browser <CR>", desc = "open file_browser" },
            { "<leader>c", "<CMD> Telescope project <CR>", desc = "open project" },
            { "<leader>ld", "<CMD> Telescope lsp_definitions <CR>", desc = "LSP jump" },
            { "<leader>li", "<CMD> Telescope lsp_implementations theme=cursor <CR>", desc = "LSP jump" },
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
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
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

                    project = {
                        theme = "ivy",
                    },

                    file_browser = {
                        initial_mode = "normal",
                        hijack_netrw = true,
                        theme = "ivy",
                        hidden = true,
                    },
                },
            })

            telescope.load_extension("project")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
        end,
    },

    -- lsp ------------------------------------------------------

    { -- lsp install
        "williamboman/mason.nvim",
        lazy = false,
        priority = 900, -- load after coq_nvim
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "ms-jpq/coq_nvim",
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
                    -- "haskell-language-server", -- Haskell
                    "hls", -- Haskell
                    "jsonls", -- json
                    "jdtls", -- Java
                    "tsserver", -- JavaScript / TypeScript
                    "kotlin_language_server", -- Kotlin
                    "ltex", -- LaTeX
                    "marksman", -- Markdown
                    "intelephense", -- php
                    "powershell_es", -- Powershell
                    "bashls", -- bash
                    "pyright", -- Python
                    -- "r_language_server", -- R
                    "rust_analyzer", -- rust
                    -- "sqlls", -- sql
                    "taplo", -- TOML
                    "vimls", -- Vim
                    "lemminx", -- xml
                    "yamlls", -- yaml
                },
            })

            local coq = require("coq")
            local lsp = require("lspconfig")
            lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities())
            lsp.clangd.setup(coq.lsp_ensure_capabilities())
            -- lsp.csharp_ls.setup{}
            lsp.cmake.setup(coq.lsp_ensure_capabilities())
            lsp.cssls.setup(coq.lsp_ensure_capabilities())
            lsp.dockerls.setup(coq.lsp_ensure_capabilities())
            lsp.gradle_ls.setup(coq.lsp_ensure_capabilities())
            lsp.html.setup(coq.lsp_ensure_capabilities())
            -- lsp.haskell-language-server.setup(coq.lsp_ensure_capabilities())
            lsp.hls.setup(coq.lsp_ensure_capabilities())
            lsp.jsonls.setup(coq.lsp_ensure_capabilities())
            lsp.jdtls.setup(coq.lsp_ensure_capabilities())
            lsp.tsserver.setup(coq.lsp_ensure_capabilities())
            lsp.kotlin_language_server.setup(coq.lsp_ensure_capabilities())
            lsp.ltex.setup(coq.lsp_ensure_capabilities())
            lsp.marksman.setup(coq.lsp_ensure_capabilities())
            lsp.intelephense.setup(coq.lsp_ensure_capabilities())
            -- lsp.powershell_es.setup{}
            lsp.bashls.setup(coq.lsp_ensure_capabilities())
            lsp.pyright.setup(coq.lsp_ensure_capabilities())
            -- lsp.r_language_server.setup{}
            lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())
            lsp.taplo.setup(coq.lsp_ensure_capabilities())
            -- lsp.sqlls.setup(coq.lsp_ensure_capabilities())
            lsp.vimls.setup(coq.lsp_ensure_capabilities())
            lsp.lemminx.setup(coq.lsp_ensure_capabilities())
            lsp.yamlls.setup(coq.lsp_ensure_capabilities())

        end,
    },

    -- language -------------------------------------------------

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

    { -- json / yaml
        "gennaro-tedesco/nvim-jqx",
        lazy = true,
        ft = { "json", "yaml" },
    },

    { -- sql tools & lsp
        "nanotee/sqls.nvim",
        lazy = true,
        ft = { "sql" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "ms-jpq/coq_nvim",
        },
        config = function()
            require("lspconfig").sqls.setup(require("coq").lsp_ensure_capabilities({
                on_attach = function(client, bufnr)
                    require("sqls").on_attach(client, bufnr)
                end,
            }))
        end,
    },

    -- TODO
    -- { -- LaTeX
    --     "lervag/vimtex",
    --     lazy = true,
    --     ft = { "tex", "plaintex", "latex", },
    --     build = ":CocInstall coc-vimtex",
    --     dependencies = {
    --         "neoclide/coc.nvim",
    --     },
    -- }, 

    -- windows --------------------------------------------------

    { --terminal
        "akinsho/toggleterm.nvim",
        lazy = false,
        config = function()

            -- settings
            local size = 20
            local start_in_insert = true
            local direction = "horizontal"
            local insert_mappings = true
            local shell = "zsh"
            local open_mapping = [[<C-t>]]

            -- init
            if package.config:sub(1,1) == "/" then

                -- unix
                require("toggleterm").setup({
                    size = size,
                    start_in_insert = start_in_insert,
                    direction = direction,
                    insert_mappings = insert_mappings,
                    shell = shell,
                    open_mapping = open_mapping,
                })

            else

                -- windows
                require("toggleterm").setup({
                    size = size,
                    start_in_insert = start_in_insert,
                    direction = direction,
                    insert_mappings = insert_mappings,
                    shell = string.format("wsl -d Ubuntu -e %s", shell),
                    open_mapping = open_mapping,
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
                vim.g.tagbar_ctags_bin = "/snap/universal-ctags/current/usr/local/bin/ctags"
            end
        end,
    },

    -- quality of life ------------------------------------------

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
                ["clients.tabnine.enabled"] = true,
                ["keymap"] = {
                    ["recommended"] = false,
                    ["pre_select"] = true,
                },
            }

            -- keymaps
            vim.cmd([[

                " init
                COQnow --shut-up

                " keymaps
                inoremap <silent><expr> <CR> pumvisible() ? "\<C-e><CR>" : "\<CR>"
                inoremap <silent><expr> <TAB> pumvisible() ? "\<C-e><TAB>" : "\<TAB>"
                inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-e><S-TAB>" : "\<S-TAB>"

            ]])

        end,
    },

    { -- auto-pairs
        "jiangmiao/auto-pairs",
        lazy = true,
        event = "InsertEnter",
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

    { -- file switcher
        "ThePrimeagen/harpoon",
        lazy = true,
        keys = {
            { "<leader>t", "<CMD> lua require(\"harpoon.mark\").add_file() <CR>", desc = "add current file" },
            -- { "<leader>ti", "<CMD> lua require(\"harpoon.ui\").toggle_quick_menu() <CR>" },
            { "<leader>1", "<CMD> lua require(\"harpoon.ui\").nav_file(1) <CR>" },
            { "<leader>2", "<CMD> lua require(\"harpoon.ui\").nav_file(2) <CR>" },
            { "<leader>3", "<CMD> lua require(\"harpoon.ui\").nav_file(3) <CR>" },
            { "<leader>4", "<CMD> lua require(\"harpoon.ui\").nav_file(4) <CR>" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("harpoon")
        end,
    },

    -- TODO -> setup
    { -- refactoring
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },
})

-- keymaps ------------------------------------------------------

-- auto center
keymap("n", "n", "nzz", keymap_opts)
keymap("n", "N", "Nzz", keymap_opts)

keymap("n", "j", "jzz", keymap_opts)
keymap("n", "k", "kzz", keymap_opts)
keymap("v", "j", "jzz", keymap_opts)
keymap("v", "k", "kzz", keymap_opts)

keymap("n", "J", "j", keymap_opts)
keymap("n", "K", "k", keymap_opts)

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", keymap_opts)

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gv", keymap_opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", keymap_opts)
keymap("v", "H", "<gv", keymap_opts)
keymap("v", "L", ">gv", keymap_opts)
