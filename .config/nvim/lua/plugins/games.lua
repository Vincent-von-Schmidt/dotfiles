return {
    {
        "NStefan002/2048.nvim",
        lazy = true,
        cmd = "Play2048",
        config = function()
            require("2048").setup()
        end,
    },
}
