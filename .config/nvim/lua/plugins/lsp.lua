local vim_util = require("utils.vim")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    lazy = true,
    event = "BufReadPre",
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", -- lua
                "clangd", -- c / c++
                "pyright", -- python
                "rust_analyzer", -- rust
            },
        })

        -- capabilities -> cmp integration
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- on attach autocmd
        local on_attach = function(_, bufnr)
            local opts = { silent = true, buffer = bufnr, noremap = true }

            -- get info of hoverd function
            vim_util.keymap("n", "<leader>li", vim.lsp.buf.hover, opts)

            -- go to definition
            vim_util.keymap("n", "<leader>ld", function()
                vim.lsp.buf.definition()
                vim.cmd('execute "normal! zz"')
            end, opts)

            -- execute code action
            vim_util.keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)

            -- goto next diagnostic info
            vim_util.keymap("n", "<leader>ln", function()
                vim.diagnostic.goto_next()
                vim.cmd('execute "normal! zz"')
            end, opts)

            -- goto prev diagnostic info
            vim_util.keymap("n", "<leader>lp", function()
                vim.diagnostic.goto_prev()
                vim.cmd('execute "normal! zz"')
            end, opts)
        end

        -- add all lsp servers installed via mason
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
