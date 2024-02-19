return {
    "HampusHauffman/block.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("block").setup({})
    end,
}
