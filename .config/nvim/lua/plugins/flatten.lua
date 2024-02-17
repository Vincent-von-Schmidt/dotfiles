return {
    "willothy/flatten.nvim",
    lazy = true,
    event = "TermEnter",
    cond = vim.g.neovide,
    enabled = false, -- TODO
    config = function()
        require("flatten").setup({})
    end,
}
