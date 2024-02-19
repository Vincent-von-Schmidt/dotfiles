return {
    {
        "NStefan002/2048.nvim",
        lazy = true,
        cmd = "Play2048",
        config = function()
            require("2048").setup()
        end,
    },
    {
        "alanfortlink/blackjack.nvim",
        lazy = true,
        cmd = "BlackJackNewGame",
        config = function()
            require("blackjack").setup({
                card_style = "large",
            })
        end,
    },
}
