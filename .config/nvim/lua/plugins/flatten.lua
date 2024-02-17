return {
    "willothy/flatten.nvim",
    lazy = false,
    cond = vim.g.neovide,
    priority = 1500,
    config = function()
        require("flatten").setup({})
    end,
}
