local vim_util = require("utils.vim")

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
        vim_util.lazy_keymap("<leader>ta", function()
            require("harpoon"):list():append()
        end),
        vim_util.lazy_keymap("<leader>ti", function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end),
        vim_util.lazy_keymap("<leader>1", function()
            require("harpoon"):list():select(1)
        end),
        vim_util.lazy_keymap("<leader>2", function()
            require("harpoon"):list():select(2)
        end),
        vim_util.lazy_keymap("<leader>3", function()
            require("harpoon"):list():select(3)
        end),
        vim_util.lazy_keymap("<leader>4", function()
            require("harpoon"):list():select(4)
        end),
    },
    -- keys = {
    --     vim_util.keymap("n", "<leader>ta", function()
    --         require("harpoon"):list():append()
    --     end),
    --     vim_util.keymap("n", "<leader>ti", function()
    --         local harpoon = require("harpoon")
    --         harpoon.ui:toggle_quick_menu(harpoon:list())
    --     end),
    --     vim_util.keymap("n", "<leader>1", function()
    --         require("harpoon"):list():select(1)
    --     end),
    --     vim_util.keymap("n", "<leader>2", function()
    --         require("harpoon"):list():select(2)
    --     end),
    --     vim_util.keymap("n", "<leader>3", function()
    --         require("harpoon"):list():select(3)
    --     end),
    --     vim_util.keymap("n", "<leader>4", function()
    --         require("harpoon"):list():select(4)
    --     end),
    -- },
    config = function()
        require("harpoon"):setup()
    end,
}
