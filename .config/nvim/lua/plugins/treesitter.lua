return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vim",
                    "regex",
                    "lua",
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
    { -- sticky strolling
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
        event = "UIEnter",
        config = function()
            require("treesitter-context").setup()
            vim.api.nvim_set_hl(0, "TreesitterContext", { link = "NormalFloat" })
        end,
    },
}
