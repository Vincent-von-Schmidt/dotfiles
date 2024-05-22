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
            "markdown",
        },
        config = function()
            -- vim.keymap.set("n", "<leader>j", function()
            --     require("nabla").popup()
            -- end, { silent = true, noremap = true })

            require("nabla").enable_virt({
                autogen = true,
                silent = true,
            })
        end,
    },
}
