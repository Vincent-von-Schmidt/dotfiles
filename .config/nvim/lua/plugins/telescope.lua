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
            { "<leader>la" },
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

            local normal_bg = "#272f35"
            local prompt_bg = "#323a40"

            vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = normal_bg })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = prompt_bg })
            vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = normal_bg, bg = normal_bg })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = prompt_bg, bg = prompt_bg })
            vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#2b3339", bg = "#e67e80" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#2b3339", bg = "#83c092" })

        end,
    },
}
