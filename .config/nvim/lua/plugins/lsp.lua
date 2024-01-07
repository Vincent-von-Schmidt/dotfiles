return {
    {
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

                -- execute code action
                vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)

                -- goto next diagnostic info
                vim.keymap.set("n", "<leader>ln", function()
                    vim.diagnostic.goto_next()
                    vim.cmd('execute "normal! zz"')
                end, opts)

                -- goto prev diagnostic info
                vim.keymap.set("n", "<leader>lp", function()
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
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "andersevenrud/cmp-tmux",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        lazy = true,
        event = "InsertEnter",
        config = function()
            -- load luansip
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
                    { name = "path" },
                    { name = "tmux" },
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
        end,
    },
}
