return {
    "willothy/flatten.nvim",
    lazy = false,
    cond = vim.g.neovide and true or false,
    priority = 1001,
    config = function()
        require("flatten").setup({})
    end,
}
