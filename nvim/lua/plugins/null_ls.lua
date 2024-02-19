return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    lazy = true,
    event = "BufReadPre",
    config = function()
        require("mason").setup()

        -- filetype / formatter / linter
        local apps = {
            { { "lua" },           { "stylua" },         {} },
            { { "py" },            { "black", "isort" }, { "pylint" } },
            { { "rs" },            { "rustfmt" },        {} },
            { { "c", "cpp", "h" }, {},                   { "cpplint" } },
            { { "hs" },            { "fourmolu" },       {} },
        }

        local install = {}
        local sources = {}
        local filetypes = {}

        local null_ls = require("null-ls")

        for _, type in ipairs(apps) do
            -- filetypes
            for _, filetype in ipairs(type[1]) do
                table.insert(type, string.format("*.%s", filetype))
            end

            -- formatter
            for _, formatter in ipairs(type[2]) do
                table.insert(install, formatter)
                table.insert(sources, null_ls.builtins.formatting[formatter])
            end

            -- linter
            for _, linter in ipairs(type[3]) do
                table.insert(install, linter)
                table.insert(sources, null_ls.builtins.diagnostics[linter])
            end
        end

        require("mason-null-ls").setup({
            ensure_installed = install,
        })

        null_ls.setup({
            sources = sources,
        })

        local null = vim.api.nvim_create_augroup("null", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = filetypes,
            group = null,
            callback = function()
                vim.lsp.buf.format()
                vim.cmd('execute "normal! zz"') -- TODO
            end,
        })
    end,
}
