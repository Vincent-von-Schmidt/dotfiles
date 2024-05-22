return {
    {
        "eandrju/cellular-automaton.nvim",
        lazy = true,
        event = "VeryLazy",
        enabled = false,
    },
    {
        "jbyuki/nabla.nvim",
        depedencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
        ft = {
            "latex",
            "tex",
            "plaintex",
        },
        config = function()
            require("nabla").enable_virt({
                autogen = true,
                silent = true,
            })
        end,
    },
    {
        "HampusHauffman/block.nvim",
        lazy = true,
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("block").setup({})
        end,
    },
}
