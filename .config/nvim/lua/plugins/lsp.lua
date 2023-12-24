return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    lazy = false,
    config = function()

        local lsp_servers = {
            "lua_ls",
            "clangd",
            "pyright",
            "rust_analyzer",
            "hls",
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        local on_attach = function(_, bufnr)
            local opts = { silent = true, buffer = bufnr, noremap = true }
            vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        end

        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = lsp_servers,
        })

        local lspconfig = require("lspconfig")

        for _, lsp in ipairs(lsp_servers) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        local luasnip = require("luasnip")
        luasnip.config.setup({})

        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
            },
            mapping = {
                ["<c-y>"] = cmp.mapping.confirm({ select = true }),

                ["<c-n>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end),

                ["<c-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),

            },
        })

    end,
}
