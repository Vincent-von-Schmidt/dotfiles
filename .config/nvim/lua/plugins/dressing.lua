return {
    {
        "stevearc/dressing.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        lazy = false,
        config = function()
            require("dressing").setup({
                input = {
                    enabled = false,
                },
                select = {
                    backend = { "telescope", "builtin" },
                    telescope = require("telescope.themes").get_cursor({}),
                },
            })
        end,
    },
}
