return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    lazy = true,
    event = "UIEnter",
    config = function()
        require("noice").setup({
            cmdline = {
                view = "cmdline",
            },
            messages = {
                view = "mini",
            },
        })
    end,
}
