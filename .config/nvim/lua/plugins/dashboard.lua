return {
    "nvimdev/dashboard-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = "UIEnter",
    config = function()
        local logo = [[
           / | / /__  ____| |  / (_)___ ___
          /  |/ / _ \/ __ \ | / / / __ `__ \
         / /|  /  __/ /_/ / |/ / / / / / / /
        /_/ |_/\___/\____/|___/_/_/ /_/ /_/
        ]]

        require("dashboard").setup({
            theme = "hyper",
            shortcut_type = "number",
            change_to_vcs_root = true, -- change cwd to file in mru
            config = {
                header = vim.split(string.rep("\n", 8) .. logo .. "\n\n", "\n"),
                shortcut = {
                    {
                        icon = " ",
                        desc = "new File ",
                        key = "i",
                        action = "ene | startinsert",
                    },
                    {
                        icon = " ",
                        desc = "tmp file ",
                        key = "a",
                        action = "Scratch",
                    },
                    {
                        icon = " ",
                        desc = "dotfiles ",
                        key = "d",
                        action = 'lua require("pickers.dotfiles")',
                    },
                    {
                        icon = " ",
                        desc = "ssh ",
                        key = "s",
                        action = "RemoteSSHFSConnect",
                    },
                    {
                        icon = " ",
                        desc = "terminal",
                        key = "t",
                        action = "edit term://zsh",
                    },
                },
                footer = { "" },
            },
        })

        vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#6ba247" })
    end,
}
