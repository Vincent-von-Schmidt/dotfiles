return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        
        require("nightfox").setup({
            options = {
                transparent = true,
            }
        })
        vim.cmd("colorscheme carbonfox")

        -- default float
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191919" })
        vim.api.nvim_set_hl(0, "NormalFloat2", { bg = "#2f2f2f" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#191919", bg = "#191919" })
        vim.api.nvim_set_hl(0, "Float2Border", { fg = "#2f2f2f", bg = "#2f2f2f" })
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#2b3339", bg = "#e67e80" })
        vim.api.nvim_set_hl(0, "Float2Title", { fg = "#2b3339", bg = "#83c092" })

    end,
}
