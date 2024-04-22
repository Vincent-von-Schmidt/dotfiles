return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            -- "nvim-telescope/telescope-ui-select.nvim",
        },
        lazy = true,
        keys = {
            { "<leader>a", "<CMD> Telescope find_files <CR>",  silent = true, noremap = true },
            { "<leader>s", "<CMD> Telescope live_grep <CR>",   silent = true, noremap = true },
            { "<leader>d", "<CMD> Telescope grep_string <CR>", silent = true, noremap = true },
            { "<leader>b", "<CMD> Telescope buffers <CR>",     silent = true, noremap = true },
        },
        cmd = "Telescope",
        config = function()
            local package = require("telescope")

            package.setup({
                defaults = {
                    mappings = {
                        -- normal mode
                        n = {
                            ["K"] = "preview_scrolling_up",
                            ["J"] = "preview_scrolling_down",
                            ["<c-e>"] = "close",
                            ["<ESC>"] = "close",
                        },
                    },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                extensions = {
                    ["fzf"] = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    -- ["ui-select"] = {
                    --     require("telescope.themes").get_cursor({}),
                    -- },
                },
            })

            -- load extension
            package.load_extension("fzf")
            -- package.load_extension("ui-select")

            -- highlight groups
            vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NormalFloat2" })
            vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Float2Border" })
            vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "FLoatTitle" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "Float2Title" })

            local telescope_autogroup = vim.api.nvim_create_augroup("Telescope", { clear = true })

            -- remove cursor line in insert prompt
            vim.api.nvim_create_autocmd("FileType", {
                group = telescope_autogroup,
                pattern = "TelescopePrompt",
                command = "setlocal nocursorline",
            })

            -- spell ui
            vim.keymap.set("n", "z=", function()
                require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
            end, { silent = true, noremap = true })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = true,
        keys = {
            { "<leader>q", ":Oil --float . <CR>", silent = true },
            { "<leader>w", ":Oil --float <CR>",   silent = true },
        },
        cmd = "Oil",
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                view_options = {
                    show_hidden = true,
                },
                float = {
                    padding = 3,
                },
            })
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = true,
        keys = {
            {
                "<leader>ta",
                function()
                    require("harpoon"):list():append()
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>ti",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>1",
                function()
                    require("harpoon"):list():select(1)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>2",
                function()
                    require("harpoon"):list():select(2)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>3",
                function()
                    require("harpoon"):list():select(3)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>4",
                function()
                    require("harpoon"):list():select(4)
                end,
                silent = true,
                noremap = true,
            },
        },
        config = function()
            require("harpoon"):setup()
        end,
    },
}
