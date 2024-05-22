return {
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
                    lualine_c = {
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                    },
                    lualine_x = {},
                    lualine_y = { "encoding", "fileformat", "filetype" },
                    lualine_z = { "location" },
                },
            })

            vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "None" })
            vim.api.nvim_set_hl(0, "lualine_c_insert", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_visual", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_command", { link = "lualine_c_normal" })
            vim.api.nvim_set_hl(0, "lualine_c_replace", { link = "lualine_c_normal" })

            -- vim.api.nvim_set_hl(
            --     0,
            --     "lualine_transitional_lualine_b_normal_to_lualine_c_normal",
            --     { bg = "None", force = true }
            -- )
            -- vim.api.nvim_set_hl(
            --     0,
            --     "lualine_transitional_lualine_b_insert_to_lualine_c_insert",
            --     { bg = "None", force = true }
            -- )
            -- vim.api.nvim_set_hl(
            --     0,
            --     "lualine_transitional_lualine_b_visual_to_lualine_c_visual",
            --     { bg = "None", force = true }
            -- )
            -- vim.api.nvim_set_hl(
            --     0,
            --     "lualine_transitional_lualine_b_command_to_lualine_c_command",
            --     { bg = "None", force = true }
            -- )
            -- vim.api.nvim_set_hl(
            --     0,
            --     "lualine_transitional_lualine_b_replace_to_lualine_c_replace",
            --     { bg = "None", force = true }
            -- )

            vim.api.nvim_create_autocmd("BufEnter", {
                -- callback = function()
                --     vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_normal_to_lualine_c_normal", { bg = "None" })
                --     vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_insert_to_lualine_c_insert", { bg = "None" })
                --     vim.api.nvim_set_hl(0, "lualine_transitional_lualine_b_visual_to_lualine_c_visual", { bg = "None" })
                --     vim.api.nvim_set_hl(
                --         0,
                --         "lualine_transitional_lualine_b_command_to_lualine_c_command",
                --         { bg = "None" }
                --     )
                --     vim.api.nvim_set_hl(
                --         0,
                --         "lualine_transitional_lualine_b_replace_to_lualine_c_replace",
                --         { bg = "None" }
                --     )
                -- end,
                command = [[
                    highlight! lualine_transitional_lualine_b_normal_to_lualine_c_normal guibg=None
                    highlight! lualine_transitional_lualine_b_insert_to_lualine_c_insert guibg=None
                    highlight! lualine_transitional_lualine_b_visual_to_lualine_c_visual guibg=None
                    highlight! lualine_transitional_lualine_b_command_to_lualine_c_command guibg=None
                    highlight! lualine_transitional_lualine_b_replace_to_lualine_c_replace guibg=None
                ]],
            })

            -- vim.cmd([[
            --
            --     highlight! lualine_transitional_lualine_b_normal_to_lualine_c_normal guibg=None
            --     highlight! lualine_transitional_lualine_b_insert_to_lualine_c_insert guibg=None
            --     highlight! lualine_transitional_lualine_b_visual_to_lualine_c_visual guibg=None
            --     highlight! lualine_transitional_lualine_b_command_to_lualine_c_command guibg=None
            --     highlight! lualine_transitional_lualine_b_replace_to_lualine_c_replace guibg=None
            --
            -- ]])
        end,
    },
}
