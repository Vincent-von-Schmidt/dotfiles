return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = "UIEnter",
    config = function()
        local logo = [[

        /$$   /$$                     /$$    /$$ /$$
        | $$$ | $$                    | $$   | $$|__/
        | $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$
        | $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/| $$| $$_  $$_  $$
        | $$  $$$$| $$$$$$$$| $$  \ $$ \  $$ $$/ | $$| $$ \ $$ \ $$
        | $$\  $$$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
        | $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
        |__/  \__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/

        ]]
        logo = string.rep("\n", 8) .. logo .. "\n\n"

        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = vim.split(logo, "\n"),
                shortcut = {
                    { desc = "new File ", action = "ene | startinsert", key = "i", group = "Number", icon = " " },
                },
                footer = { "" },
            },
        })
    end,
}
