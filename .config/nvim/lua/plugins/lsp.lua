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
            vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, opts)

            -- go to definition
            vim.keymap.set("n", "<leader>ld", function()
                vim.lsp.buf.definition()
                vim.cmd('execute "normal! zz"')
            end, opts)

            -- go to reference
            vim.keymap.set("n", "<leader>lr", function()
                vim.lsp.buf.references()
                vim.cmd('execute "normal! zz"')
            end, opts)

            -- execute code action
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

            -- rename
            vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
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
