local keymap = vim.keymap.set
local keymap_opts = { buffer = bufnr, silent = true, noremap = true }

-- editor -------------------------------------------------------

-- esc
keymap("i", "<c-e>", "<ESC>", keymap_opts)
keymap("v", "<c-e>", "<ESC>", keymap_opts)
keymap("c", "<c-e>", "<ESC>", keymap_opts)
keymap("n", "<c-e>", "<ESC>", keymap_opts)

-- auto center
keymap("n", "n", "nzz", keymap_opts)
keymap("n", "N", "Nzz", keymap_opts)

keymap("n", "j", "jzz", keymap_opts)
keymap("n", "k", "kzz", keymap_opts)
keymap("v", "j", "jzz", keymap_opts)
keymap("v", "k", "kzz", keymap_opts)
keymap("v", "J", "Jzz", keymap_opts)
keymap("v", "K", "Kzz", keymap_opts)

-- no auto center
keymap("n", "J", "j", keymap_opts)
keymap("n", "K", "k", keymap_opts)

keymap("v", "<CR>", "<ESC>", keymap_opts)

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", keymap_opts)

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gvzz", keymap_opts)
keymap("v", "K", ":m '<-2<CR>gv=gvzz", keymap_opts)
keymap("v", "H", "<gv", keymap_opts)
keymap("v", "L", ">gv", keymap_opts)

-- telescope ----------------------------------------------------

telescope = {
    { "<leader>a", "<CMD> Telescope find_files <CR>" },
    { "<leader>s", "<CMD> Telescope live_grep <CR>" },
    { "<leader>q", "<CMD> Telescope file_browser <CR>" },
    { "<leader>c", "<CMD> Telescope project <CR>" },
    { "<leader>ld", "<CMD> Telescope lsp_definitions <CR>" },
    { "<leader>li", "<CMD> Telescope lsp_implementations theme=cursor <CR>" },
}

require('telescope').setup({
    defaults = {
        mappings = {
            -- insert
            i = {
                ["<leader>o"] = "select_vertical",
                ["<leader>p"] = "select_horizontal",
            },

            -- normal
            n = {
                ["<leader>o"] = "select_vertical",
                ["<leader>p"] = "select_horizontal",
            },
        },
}})

-- undotree -----------------------------------------------------

undotree = {
    { "<leader>w", "<CMD> UndotreeToggle <CR> <CMD> UndotreeFocus <CR>" },
}

-- coq ----------------------------------------------------------

vim.g.coq_settings = {
    ["keymap.jump_to_mark"] = "<c-h>"
}

vim.cmd([[

    inoremap <silent><expr> <CR> pumvisible() ? "\<C-e><CR>" : "\<CR>"
    inoremap <silent><expr> <TAB> pumvisible() ? "\<C-e><TAB>" : "\<TAB>"
    inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-e><S-TAB>" : "\<S-TAB>"

]])

-- NoNeckPain ---------------------------------------------------

no_neck_pain = {
    { "<leader>z", "<CMD> NoNeckPain <CR>" },
}

-- harpoon ------------------------------------------------------
-
harpoon = {
    { "<leader>ta", "<CMD> lua require(\"harpoon.mark\").add_file() <CR>" },
    { "<leader>ti", "<CMD> lua require(\"harpoon.ui\").toggle_quick_menu() <CR>" },
    { "<leader>1", "<CMD> lua require(\"harpoon.ui\").nav_file(1) <CR>" },
    { "<leader>2", "<CMD> lua require(\"harpoon.ui\").nav_file(2) <CR>" },
    { "<leader>3", "<CMD> lua require(\"harpoon.ui\").nav_file(3) <CR>" },
    { "<leader>4", "<CMD> lua require(\"harpoon.ui\").nav_file(4) <CR>" },
}
