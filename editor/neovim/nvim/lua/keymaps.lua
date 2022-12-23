-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- init ---------------------------------------------------------
local keymap = vim.keymap.set
local opts = { buffer = bufnr, silent = true, noremap = true }

-- leader key ---------------------------------------------------
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- esc ----------------------------------------------------------
keymap("i", "jj", "<ESC>", opts)

-- search -------------------------------------------------------

-- auto center
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- tab
keymap("n", "<leader>tl", "<CMD> tabnext <CR>", opts)
keymap("n", "<leader>th", "<CMD> tabprevious <CR>", opts)
keymap("n", "<leader>tw", "<CMD> tabclose <CR>", opts)

-- lsp ----------------------------------------------------------
keymap("n", "<leader>li", vim.lsp.buf.hover , opts) -- shows information of hovered var / fun

-- telescope
keymap("n", "<leader>lj", "<CMD> Telescope lsp_definitions <CR>", opts) -- jumps to the definition

-- telescope ----------------------------------------------------
local telescope = require("telescope.builtin")
keymap("n", "<leader>a", telescope.find_files, opts)
keymap("n", "<leader>s", telescope.live_grep, opts)
-- keymap("n", "<leader>d", "<CMD> Telescope file_browser <CR>", opts)

-- lsp
keymap("n", "<leader>d", "<CMD> Telescope lsp_references <CR>", opts) -- shows where the hovered var is used

require("telescope").setup {
  defaults = {
    mappings = {
      -- insert_mode
      i = {
        ["<leader>o"] = "select_vertical", -- split vertical
        ["<leader>p"] = "select_horizontal", -- split horizontal
        ["<leader>t"] = "select_tab", -- open in new tab
      },

      -- normal_mode
      n = {
        ["<leader>o"] = "select_vertical", -- split vertical
        ["<leader>p"] = "select_horizontal", -- split horizontal
        ["<leader>t"] = "select_tab", -- open in new tab
      }
}}}

-- nvim tree ----------------------------------------------------
keymap("n", "<leader>q", "<CMD> NvimTreeToggle <CR>", opts)

-- UndoTree -----------------------------------------------------
keymap("n", "<leader>w", "<CMD> UndotreeToggle <CR> <CMD> UndotreeFocus <CR>", opts)

-- TagTree ------------------------------------------------------
keymap("n", "<leader>e", "<CMD> TagbarToggle <CR>", opts)

-- Terminal -----------------------------------------------------
require("toggleterm").setup({
  open_mapping = [[<C-t>]]
})

-- Quality of life ----------------------------------------------

-- substitute highlighted word
keymap("n", "<leader>g", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- move highlighted
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- zen mode
keymap("n", "<leader>z", "<CMD> TZAtaraxis <CR>", opts)
