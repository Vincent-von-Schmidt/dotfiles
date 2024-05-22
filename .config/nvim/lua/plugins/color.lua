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

            vim.api.nvim_create_autocmd("TextYankPost", {
                group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
                callback = function()
                    vim.highlight.on_yank()
                end,
            })
        end,
    },
}
