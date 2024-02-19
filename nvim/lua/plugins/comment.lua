return {
    "terrortylor/nvim-comment",
    lazy = true,
    keys = { "gc" },
    config = function()
        require("nvim_comment").setup()
    end,
}
