return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "andersevenrud/cmp-tmux",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "Exafunction/codeium.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    event = "InsertEnter",
    config = function()
        -- load luansip
        local luasnip = require("luasnip")
        luasnip.config.setup({
            enable_autosnippets = true,
        })

        -- load snippets
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "./lua/snip/luasnippets" },
        })
        require("luasnip.loaders.from_snipmate").lazy_load({
            paths = { "./lua/snip/snippets" },
        })

        -- codium - ai - copilot
        require("codeium").setup({})

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
                { name = "codeium" },
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
}
