return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "nvim-lua/plenary.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    lazy = false,
    config = function()
        require("mason").setup()

        local formatter = {
            "stylua", -- lua
            "black", -- python
            "isort", -- python
            "clang-format", -- python
            "rustfmt", -- rust
        }

        local linter = {
            "selene", -- lua
            "pylint", -- python
            "cpplint", -- c / c++
        }

        local install = {}
        local sources = {}

        local null_ls = require("null-ls")

        for _, el in ipairs(formatter) do
            table.insert(sources, null_ls.builtins.formatting[el])
            table.insert(install, el)
        end

        for _, el in ipairs(linter) do
            table.insert(sources, null_ls.builtins.diagnostics[el])
            table.insert(install, el)
        end

        require("mason-null-ls").setup({
            ensure_installed = install,
        })

        null_ls.setup({
            sources = sources,
        })

        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
}
