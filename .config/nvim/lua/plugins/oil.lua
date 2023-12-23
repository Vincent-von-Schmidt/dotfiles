return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    keys = {
        { "<leader>q", ":Oil --float . <CR>", { silent = true, noremap = true }, },
        { "<leader>w", ":Oil --float <CR>", { silent = true, noremap = true } },
    },
    config = function()

        require("oil").setup({
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 3,
            },
        })

    end,
}
