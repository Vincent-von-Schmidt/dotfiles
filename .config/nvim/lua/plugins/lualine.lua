return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "folke/noice.nvim",
    },
    lazy = true,
    event = "UIEnter",
    config = function()
        vim.opt.showmode = false

        require("lualine").setup({
            options = {
                -- globalstatus = true,
                icons_enabled = false,
                -- component_separators = { left = "|", right = "|" },
                -- section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "\\", right = "/" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_y = { "encoding", "fileformat", "filetype" },
                lualine_z = { "location" },
            },
        })
    end,
}
