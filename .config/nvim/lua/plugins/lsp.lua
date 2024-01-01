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

        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "buffer" },
            },
            mapping = {
                ["<c-y>"] = cmp.mapping.confirm({ select = true }),
                ["<c-k>"] = cmp.mapping.scroll_docs(-4),
                ["<c-j>"] = cmp.mapping.scroll_docs(4),

                ["<c-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),

                ["<c-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end),

                ["<tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<s-tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
        })

        -- design
        -- vim.api.nvim_set_highlight(0, "CmpItemMenu", { link = "NormalFloat" })
    end,
}
