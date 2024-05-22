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
}
