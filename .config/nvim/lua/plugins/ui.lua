return {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        lazy = true,
        event = "UIEnter",
        config = function()
            require("noice").setup({
                -- cmdline = {
                --     view = "cmdline",
                -- },
                messages = {
                    view = "mini",
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "25%",
                            col = "50%",
                        },
                        border = {
                            style = "none",
                            padding = { 1, 2 },
                        },
                        filter_options = {},
                        win_options = {
                            winhighlight = "NormalFloat:NormalFloat, FloatBorder:FloatBorder",
                        },
                    },
                },
            })
        end,
    },
    { -- sticky strolling
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
        event = "UIEnter",
        config = function()
            require("treesitter-context").setup()
            vim.api.nvim_set_hl(0, "TreesitterContext", { link = "NormalFloat" })
        end,
    },
    -- {
    --     "nvim-telescope/telescope-ui-select.nvim",
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     lazy = true,
    --     event = "VeryLazy",
    --     config = function()
    --         require("telescope").load_extension("ui-select")
    --     end,
    -- },
}
