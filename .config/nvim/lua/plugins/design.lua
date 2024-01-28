local vim_util = require("utils.vim")

return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("nightfox").setup({
            options = {
                transparent = true,
            },
        })
        vim.cmd("colorscheme carbonfox")

        -- default float
        vim_util.highlight("NormalFloat", { bg = "#191919" })
        vim_util.highlight("NormalFloat2", { bg = "#2f2f2f" })
        vim_util.highlight("FloatBorder", { fg = "#191919", bg = "#191919" })
        vim_util.highlight("Float2Border", { fg = "#2f2f2f", bg = "#2f2f2f" })
        vim_util.highlight("FloatTitle", { fg = "#2b3339", bg = "#e67e80" })
        vim_util.highlight("Float2Title", { fg = "#2b3339", bg = "#83c092" })

        -- visual selection
        vim_util.highlight("Visual", { link = "CursorLine" })
    end,
}
