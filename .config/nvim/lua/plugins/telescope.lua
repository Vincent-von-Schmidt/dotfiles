return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        lazy = true,
        keys = {
            { "<leader>a", "<CMD> Telescope find_files <CR>" },
            { "<leader>s", "<CMD> Telescope live_grep <CR>" },
        },
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
                        }
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
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            -- load extension
            package.load_extension("fzf")

            -- highlight groups
            vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NormalFloat2" })
            vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Float2Border" })
            vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "FLoatTitle" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "Float2Title" })

        end,
    },
}
