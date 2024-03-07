return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                styles = {
                    transparency = false,
                },
            })
            vim.cmd("colorscheme rose-pine")

            vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
            vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })

            -- default float
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#191919" })
            vim.api.nvim_set_hl(0, "NormalFloat2", { bg = "#2f2f2f" })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#191919", bg = "#191919" })
            vim.api.nvim_set_hl(0, "Float2Border", { fg = "#2f2f2f", bg = "#2f2f2f" })
            -- vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#2b3339", bg = "#e67e80" })
            -- vim.api.nvim_set_hl(0, "Float2Title", { fg = "#2b3339", bg = "#83c092" })
            vim.api.nvim_set_hl(0, "FloatTitle", { link = "lualine_a_replace" })
            vim.api.nvim_set_hl(0, "Float2Title", { link = "lualine_a_command" })

            -- visual selection
            vim.api.nvim_set_hl(0, "Visual", { link = "CursorLine" })

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                command = "setlocal cursorline",
            })

            vim.api.nvim_create_autocmd({ "BufLeave" }, {
                command = "setlocal nocursorline",
            })
        end,
    },
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
                    lualine_b = { "branch", "diff", "diagnostics", "filename" },
                    lualine_c = {},
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

            vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_normal_to_lualine_c_normal", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_insert_to_lualine_c_insert", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_visual_to_lualine_c_visual", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_command_to_lualine_c_command", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_replace_to_lualine_c_replace", { bg = "None" })
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
