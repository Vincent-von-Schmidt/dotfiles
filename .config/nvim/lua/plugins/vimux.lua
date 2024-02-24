return {
    "Vincent-von-Schmidt/vimux.nvim",
    dev = true,
    lazy = true,
    keys = {
        "<leader>o",
        "<leader>p",
    },
    config = function()
        require("vimux").setup()
    end,
}
