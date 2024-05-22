return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = true,
        keys = {
            {
                "<leader>ta",
                function()
                    require("harpoon"):list():append()
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>ti",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>1",
                function()
                    require("harpoon"):list():select(1)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>2",
                function()
                    require("harpoon"):list():select(2)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>3",
                function()
                    require("harpoon"):list():select(3)
                end,
                silent = true,
                noremap = true,
            },
            {
                "<leader>4",
                function()
                    require("harpoon"):list():select(4)
                end,
                silent = true,
                noremap = true,
            },
        },
        config = function()
            require("harpoon"):setup()
        end,
    },
}
