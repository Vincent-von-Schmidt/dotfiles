local vim_util = require("utils.vim")

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

        vim_util.keymap("n", "<leader>ta", function()
            harpoon:list():append()
        end)
        vim_util.keymap("n", "<leader>ti", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim_util.keymap("n", "<leader>1", function()
            harpoon:list():select(1)
        end)
        vim_util.keymap("n", "<leader>2", function()
            harpoon:list():select(2)
        end)
        vim_util.keymap("n", "<leader>3", function()
            harpoon:list():select(3)
        end)
        vim_util.keymap("n", "<leader>4", function()
            harpoon:list():select(4)
        end)

        -- design
        -- local primary_color = "#191919"
        -- local secondary_color = "#2f2f2f"

        -- vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = primary_color })
    end,
}
