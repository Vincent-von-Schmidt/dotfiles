return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
    },
    lazy = true,
    keys = {
        { "<leader>a", "<CMD> Telescope find_files <CR>",             silent = true, noremap = true },
        { "<leader>s", "<CMD> Telescope live_grep <CR>",              silent = true, noremap = true },
        { "<leader>d", "<CMD> Telescope grep_string <CR>",            silent = true, noremap = true },
        { "<leader>b", "<CMD> Telescope buffers theme=dropdown <CR>", silent = true, noremap = true },
    },
    cmd = "Telescope",
    config = function()
        local package = require("telescope")

        package.setup({
            defaults = {
                mappings = {
                    -- normal mode
                    n = {
                        ["K"] = "preview_scrolling_up",
                        ["J"] = "preview_scrolling_down",
                        ["<c-e>"] = "close",
                        ["<ESC>"] = "close",
                    },
                },
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                ["fzf"] = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_cursor({}),
                },
            },
        })

        -- load extension
        package.load_extension("fzf")
        package.load_extension("ui-select")

        -- highlight groups
        vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NormalFloat2" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Float2Border" })
        vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "TelescopeBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "FLoatTitle" })
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "Float2Title" })
    end,
}
