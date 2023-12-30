return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    lazy = false,
    config = function()
        require("mason").setup()

        local lsp_server = {
            "lua_ls",
            "clangd",
            "pyright",
            "rust_analyzer",
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        local on_attach = function(_, bufnr)
            local opts = { silent = true, buffer = bufnr, noremap = true }
            vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        end

        require("mason-lspconfig").setup({
            ensure_installed = lsp_server,
        })

        local lspconfig = require("lspconfig")

        for _, lsp in ipairs(lsp_server) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        local luasnip = require("luasnip")
        luasnip.config.setup({})

        -- load snippets
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "./lua/luasnippets" },
        })
        -- require("luasnip.loaders.from_snipmate").lazy_load({
        --     paths = { "./lua/snippets" },
        -- })

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
                    else
                        vim.cmd('execute "normal! i\\<c-n>"')
                    end
                end),

                ["<c-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        vim.cmd('execute "normal! i\\<c-p>"')
                    end
                end),

                ["<tab>"] = cmp.mapping(function()
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        vim.cmd('execute "normal! i\\<tab> "')
                    end
                end, { "i", "s" }),

                ["<s-tab>"] = cmp.mapping(function()
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        vim.cmd('execute "normal! i\\<s-tab>"')
                    end
                end, { "i", "s" }),
            },
        })
    end,
}
