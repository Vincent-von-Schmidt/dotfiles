return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "VeryLazy",
    config = function()

        local harpoon = require("harpoon")
        harpoon:setup()

        local opts = { silent = true, noremap = true }
        vim.keymap.set("n", "<leader>ta", function() harpoon:list():append() end, opts)
        vim.keymap.set("n", "<leader>ti", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, opts)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, opts)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, opts)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, opts)

    end,
}
