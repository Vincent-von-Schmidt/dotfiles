-- editor -------------------------------------------------------
-- vim.opt.guicursor = " "
vim.opt.hlsearch = false
vim.o.showtabline = 2
vim.opt.colorcolumn = "90"

-- indent line
require("indent_blankline").setup({
    show_current_context = true,
    show_current_context_start = true,
})

-- ui -----------------------------------------------------------
require("noice").setup({
    cmdline = {
        enabled = true,
        view = "cmdline_popup",
    },
    views = {
      cmdline_popup = {
        relative = "editor",
        position = {
          row = "40%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "72%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
})

-- colorscheme --------------------------------------------------

require("nightfox").setup({
  options = {
    -- transparent background
    transparent = false
  }
})

-- set colorscheme
vim.cmd("colorscheme carbonfox")
-- vim.cmd("colorscheme darcula-solid")

-- statusline ---------------------------------------------------

require("hardline").setup({
  bufferline = false,
  bufferline_settings = {
    exlude_terminal = false,
    show_index = false
  },
  theme = "dracula",
  section = {
    {class = "mode", item = require("hardline.parts.mode").get_item},
    {class = "med", item = require("hardline.parts.filename").get_item},
    "%<",
    {class = "med", item = "%="},
    {class = "high", item = require("hardline.parts.filetype").get_item, hide = 60},
    {class = "mode", item = require("hardline.parts.line").get_item}
  }
})

-- tabline ------------------------------------------------------

require("tabby.tabline").use_preset("tab_only", {
        theme= {
                fill = "TabLineFill",
                head = "TabLine",
                current_tab = "TabLineSel",
                tab = "TabLine",
                win = "TabLine",
                tail = "TabLine",
        },
        nerdfont = true,
        buf_name = {
                mode = "'unique'|'relative'|'tail'|'shorten'",
        },
})

-- dashboard ----------------------------------------------------
local dashboard = require("dashboard")

dashboard.custom_header = {
  "NNNNNNNN        NNNNNNNN                                  VVVVVVVV           VVVVVVVV iiii                          ",
  "N:::::::N       N::::::N                                  V::::::V           V::::::Vi::::i                         ",
  "N::::::::N      N::::::N                                  V::::::V           V::::::V iiii                          ",
  "N:::::::::N     N::::::N                                  V::::::V           V::::::V                               ",
  "N::::::::::N    N::::::N    eeeeeeeeeeee       ooooooooooo V:::::V           V:::::Viiiiiii    mmmmmmm    mmmmmmm   ",
  "N:::::::::::N   N::::::N  ee::::::::::::ee   oo:::::::::::ooV:::::V         V:::::V i:::::i  mm:::::::m  m:::::::mm ",
  "N:::::::N::::N  N::::::N e::::::eeeee:::::eeo:::::::::::::::oV:::::V       V:::::V   i::::i m::::::::::mm::::::::::m",
  "N::::::N N::::N N::::::Ne::::::e     e:::::eo:::::ooooo:::::o V:::::V     V:::::V    i::::i m::::::::::::::::::::::m",
  "N::::::N  N::::N:::::::Ne:::::::eeeee::::::eo::::o     o::::o  V:::::V   V:::::V     i::::i m:::::mmm::::::mmm:::::m",
  "N::::::N   N:::::::::::Ne:::::::::::::::::e o::::o     o::::o   V:::::V V:::::V      i::::i m::::m   m::::m   m::::m",
  "N::::::N    N::::::::::Ne::::::eeeeeeeeeee  o::::o     o::::o    V:::::V:::::V       i::::i m::::m   m::::m   m::::m",
  "N::::::N     N:::::::::Ne:::::::e           o::::o     o::::o     V:::::::::V        i::::i m::::m   m::::m   m::::m",
  "N::::::N      N::::::::Ne::::::::e          o:::::ooooo:::::o      V:::::::V        i::::::im::::m   m::::m   m::::m",
  "N::::::N       N:::::::N e::::::::eeeeeeee  o:::::::::::::::o       V:::::V         i::::::im::::m   m::::m   m::::m",
  "N::::::N        N::::::N  ee:::::::::::::e   oo:::::::::::oo         V:::V          i::::::im::::m   m::::m   m::::m",
  "NNNNNNNN         NNNNNNN    eeeeeeeeeeeeee     ooooooooooo            VVV           iiiiiiiimmmmmm   mmmmmm   mmmmmm",
}

dashboard.custom_center = {
  { icon = " ", desc = "open files", action = "Telescope find_files" },
  { icon = " ", desc = "open project", action = "Telescope project" },
  { icon = " ", desc = "keymaps", action = "Telescope keymaps" },
  { icon = " ", desc = "colorscheme", action = "Telescope colorscheme" },
  { icon = " ", desc = "settings", action = ":lua print('currently not available')" },
}


-- miscellaneous -------------------------------------------------

require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
    "regex"
  },
  delay = 100,
  under_cursor = true,
  large_file_cutoff = nil,
  large_file_overrides = nil,
  min_count_to_highlight = 1
})
