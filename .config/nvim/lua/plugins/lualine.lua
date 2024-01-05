return {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "UIEnter",
    config = function()
        vim.opt.showmode = false

        require("lualine").setup({
            options = {
                icons_enabled = false,
                -- component_separators = { left = "", right = "", },
                -- section_separators = { left = "", right = "", },
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { '' },
                lualine_z = { 'location' }
            },
        })
    end,
}
