return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    enabled = false,
    lazy = true,
    cmd = "Neogit",
    config = function()
        require("neogit").setup()
    end,
}
