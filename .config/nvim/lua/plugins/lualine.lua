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

            vim.api.nvim_create_autocmd("BufEnter", {
                command = [[
                    highlight! lualine_transitional_lualine_b_normal_to_lualine_c_normal guibg=None
                    highlight! lualine_transitional_lualine_b_insert_to_lualine_c_insert guibg=None
                    highlight! lualine_transitional_lualine_b_visual_to_lualine_c_visual guibg=None
                    highlight! lualine_transitional_lualine_b_command_to_lualine_c_command guibg=None
                    highlight! lualine_transitional_lualine_b_replace_to_lualine_c_replace guibg=None

                    highlight! lualine_c_normal guibg=None
                    highlight! link lualine_c_normal lualine_c_normal
                    highlight! link lualine_c_insert lualine_c_normal
                    highlight! link lualine_c_visual lualine_c_normal
                    highlight! link lualine_c_command lualine_c_normal
                    highlight! link lualine_c_replace lualine_c_normal
                ]],
            })

        end,
    },
}
