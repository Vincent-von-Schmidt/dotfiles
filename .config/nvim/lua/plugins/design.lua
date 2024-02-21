return {
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup()
            vim.cmd("colorscheme rose-pine")

            vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
            vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })

            -- default float
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191919" })
            vim.api.nvim_set_hl(0, "NormalFloat2", { bg = "#2f2f2f" })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#191919", bg = "#191919" })
            vim.api.nvim_set_hl(0, "Float2Border", { fg = "#2f2f2f", bg = "#2f2f2f" })
            vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#2b3339", bg = "#e67e80" })
            vim.api.nvim_set_hl(0, "Float2Title", { fg = "#2b3339", bg = "#83c092" })

            -- visual selection
            vim.api.nvim_set_hl(0, "Visual", { link = "CursorLine" })
        end,
    },
    -- {
    --     "EdenEast/nightfox.nvim",
    --     lazy = true,
    --     -- priority = 1000,
    --     config = function()
    --         require("nightfox").setup()
    --         -- vim.cmd("colorscheme carbonfox")
    --
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
    --         vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
    --
    --         -- default float
    --         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191919" })
    --         vim.api.nvim_set_hl(0, "NormalFloat2", { bg = "#2f2f2f" })
    --         vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#191919", bg = "#191919" })
    --         vim.api.nvim_set_hl(0, "Float2Border", { fg = "#2f2f2f", bg = "#2f2f2f" })
    --         vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#2b3339", bg = "#e67e80" })
    --         vim.api.nvim_set_hl(0, "Float2Title", { fg = "#2b3339", bg = "#83c092" })
    --
    --         -- visual selection
    --         vim.api.nvim_set_hl(0, "Visual", { link = "CursorLine" })
    --     end,
    -- },
    {
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
                    globalstatus = true,
                    icons_enabled = false,
                    -- component_separators = { left = "|", right = "|" },
                    -- section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    -- component_separators = { left = "\\", right = "/" },
                    -- section_separators = { left = "", right = "" },
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

            vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_c_insert", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_visual", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_command", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_replace", { link = "lualine_c_normal" })
        end,
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        lazy = true,
        event = "UIEnter",
        config = function()
            require("noice").setup({
                -- cmdline = {
                --     view = "cmdline",
                -- },
                messages = {
                    view = "mini",
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "25%",
                            col = "50%",
                        },
                        border = {
                            style = "none",
                            padding = { 1, 2 },
                        },
                        filter_options = {},
                        win_options = {
                            winhighlight = "NormalFloat:NormalFloat, FloatBorder:FloatBorder",
                        },
                    },
                },
            })
        end,
    },
    {
        "HampusHauffman/block.nvim",
        lazy = true,
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("block").setup({})
        end,
    },
}
