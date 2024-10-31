return {
    {
        "amitds1997/remote-nvim.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
        cmd = {
            "RemoteStart",
            "RemoteStop",
            "RemoteInfo",
            "RemoteCleanup",
            "RemoteConfigDel",
            "RemoteLog",
        },
        config = function()
            require("remote-nvim").setup()
        end,
    },
    {
        "eandrju/cellular-automaton.nvim",
        enabled = false,
        lazy = true,
        event = "VeryLazy",
    },
    {
        "jbyuki/nabla.nvim",
        enabled = false,
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
        enabled = false,
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("block").setup({})
        end,
    },
    {
        "NStefan002/2048.nvim",
        enabled = false,
        lazy = true,
        cmd = "Play2048",
        config = function()
            require("2048").setup()
        end,
    },
    {
        "alanfortlink/blackjack.nvim",
        enabled = false,
        lazy = true,
        cmd = "BlackJackNewGame",
        config = function()
            require("blackjack").setup({
                card_style = "large",
            })
        end,
    },
    {
        "mbbill/undotree",
        enabled = false,
        lazy = true,
        keys = {
            { "<leader>u", ":UndotreeToggle <CR> :UndotreeFocus <CR>", silent = true },
        },
        config = function()
            vim.g.undotree_WindowLayout = 3
        end,
    },
}
