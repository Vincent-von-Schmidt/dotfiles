local vim_util = require("utils.vim")

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
            vim_util.highlight("TelescopeNormal", { link = "NormalFloat" })
            vim_util.highlight("TelescopePromptNormal", { link = "NormalFloat2" })
            vim_util.highlight("TelescopeBorder", { link = "FloatBorder" })
            vim_util.highlight("TelescopePromptBorder", { link = "Float2Border" })
            vim_util.highlight("TelescopeTitle", { link = "TelescopeBorder" })
            vim_util.highlight("TelescopePromptTitle", { link = "FLoatTitle" })
            vim_util.highlight("TelescopePreviewTitle", { link = "Float2Title" })
        end,
    },
}
