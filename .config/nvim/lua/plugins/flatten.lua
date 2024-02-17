return {
    "willothy/flatten.nvim",
    lazy = false,
    cond = vim.g.neovide,
    config = function()
        require("flatten").setup({})
    end,
}
