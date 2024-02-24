return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vim",
                    "regex",
                    "lua",
                    "bash",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "rust",
                    "haskell",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
