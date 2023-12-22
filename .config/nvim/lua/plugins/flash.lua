return {
    "folke/flash.nvim",
    lazy = true,
    keys = {
        { "s", function() require("flash").jump() end, }
    }
}
