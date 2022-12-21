require("plugins")
require("keymaps")
require("design")

-- editor -------------------------------------------------------

-- linenumbers
vim.opt.relativenumber = true
vim.opt.number = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- wrap
vim.opt.wrap = false

-- clipboard -> global
vim.o.clipboard = "unnamedplus"

-- terminal colors
vim.opt.termguicolors = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- language
if package.config:sub(1,1) == "\\" then
  vim.cmd("language en_us")
end

-- commenter ----------------------------------------------------
require("nvim_comment").setup()

-- surround -----------------------------------------------------
require("nvim-surround").setup()

-- terminal -----------------------------------------------------
if package.config:sub(1,1) == "/" then

  -- linux / mac
  require("toggleterm").setup({
    size = 20,
    start_in_insert = true,
    direction = "horizontal",
    insert_mappings = true
  })

else

  -- windows
  require("toggleterm").setup({
    size = 20,
    start_in_insert = true,
    direction = "horizontal",
    insert_mappings = true,
    shell = "wsl"
  })

end

-- nvim tree ----------------------------------------------------
require("nvim-tree").setup()

-- telescope ----------------------------------------------------
local telescope = require("telescope")
telescope.load_extension("project")
telescope.load_extension("repo")
telescope.load_extension("heading")
telescope.load_extension("file_browser")
telescope.load_extension("flutter")
telescope.load_extension("noice")

require("telescope-tabs").setup()
require("neoclip").setup()

require("telescope").setup({
    extension = {
        project = {
            sync_with_nvim_tree = true,
        }
    }
})

-- treesitter ---------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "c",
    "cpp",
    "rust",
    "python",
    "dart",
    "markdown"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- lsp ----------------------------------------------------------
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua", -- Lua
    "clangd", -- C / C++
    -- "csharp_ls", -- C#
    "cmake", -- CMake
    "cssls", -- CSS
    "dockerls", -- Docker
    "gradle_ls", -- Gradle
    "html", -- html
    -- "hls", -- Haskell
    "jsonls", -- json
    "jdtls", -- Java
    "tsserver", -- JavaScript / TypeScript
    "kotlin_language_server", -- Kotlin
    "ltex", -- LaTeX
    "marksman", -- Markdown
    "intelephense", -- php
    -- "powershell_es", -- Powershell
    "bashls", -- bash
    "pyright", -- Python
    -- "r_language_server", -- R
    "rust_analyzer", -- rust
    "sqlls", -- sql
    "taplo", -- TOML
    "vimls", -- Vim
    "lemminx", -- xml
    "yamlls", -- yaml
  }
})

local lsp = require("lspconfig")
lsp.sumneko_lua.setup{}
lsp.clangd.setup{}
-- lsp.csharp_ls.setup{}
lsp.cmake.setup{}
lsp.cssls.setup{}
lsp.dockerls.setup{}
lsp.gradle_ls.setup{}
lsp.html.setup{}
-- lsp.hls.setup{}
lsp.jsonls.setup{}
lsp.jdtls.setup{}
lsp.tsserver.setup{}
lsp.kotlin_language_server.setup{}
lsp.ltex.setup{}
lsp.marksman.setup{}
lsp.intelephense.setup{}
-- lsp.powershell_es.setup{}
lsp.bashls.setup{}
lsp.pyright.setup{}
-- lsp.r_language_server.setup{}
lsp.rust_analyzer.setup{}
lsp.sqlls.setup{}
lsp.taplo.setup{}
lsp.vimls.setup{}
lsp.lemminx.setup{}
lsp.yamlls.setup{}

-- flutter / dart
require("flutter-tools").setup()

-- tagbar -------------------------------------------------------
-- ctags for snap installation
if package.config:sub(1,1) == "/" then
  -- Linux / MacOS
  vim.g.tagbar_ctags_bin = "/snap/universal-ctags/current/usr/local/bin/ctags"

else
  -- windows

end

-- LaTeX --------------------------------------------------------
-- vim.g.vimtex_view_method = ""
-- vim.g.vimtex_view_general_viewer = ""

