vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
        use "wbthomason/packer.nvim"

        -- file browser --------------------------------------------------

        -- file tree
        use { "nvim-tree/nvim-tree.lua", requires = {
            "nvim-tree/nvim-web-devicons"
        }}

        -- fuzzy finder
        use { "nvim-telescope/telescope.nvim", requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "sharkdp/fd",
            "BurntSushi/ripgrep",
        }}

        -- telescope extensions
        use "nvim-telescope/telescope-project.nvim"
        use "LukasPietzschmann/telescope-tabs"
        use "cljoly/telescope-repo.nvim"
        use "crispgm/telescope-heading.nvim"
        use "AckslD/nvim-neoclip.lua"
        use "nvim-telescope/telescope-file-browser.nvim"

        -- lsp / linter --------------------------------------------------

        use { "williamboman/mason.nvim", requires = {
            "williamboman/mason-lspconfig.nvim",
             "neovim/nvim-lspconfig",
        }}

        -- flutter / dart
        use "akinsho/flutter-tools.nvim"

        -- Design --------------------------------------------------------

        -- color scheme
        use "EdenEast/nightfox.nvim"
        use "folke/tokyonight.nvim"
        use { "briones-gabriel/darcula-solid.nvim", requires = {
            "rktjmp/lush.nvim",
        }}

        -- tabline
        use "nanozuki/tabby.nvim"

        -- statusline
        use "ojroques/nvim-hardline"

        -- icons
        use "nvim-tree/nvim-web-devicons"

        -- indent line
        use "lukas-reineke/indent-blankline.nvim"

        -- ui
        use { "folke/noice.nvim", requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }}

        -- windows -------------------------------------------------------

        -- on startup ----------------------------------------------------
        use "glepnir/dashboard-nvim"

        -- terminal
        use "akinsho/toggleterm.nvim"

        -- undotree
        use "mbbill/undotree"

        -- outline / tagbar
        use "preservim/tagbar"

        -- Quality of life -----------------------------------------------

        -- intellisense
        use "neoclide/coc.nvim"
        -- use "hrsh7th/nvim-cmp"

        -- highlights the same vars
        use "RRethy/vim-illuminate"

        -- autocomplete brackets
        use "jiangmiao/auto-pairs"

        -- commenter -> gcc comment/uncomment
        use "terrortylor/nvim-comment"

        -- surround -> ysiw) / ds) -> (word) / word
        use "kylechui/nvim-surround"

        -- miscellaneous -------------------------------------------------

        -- latex
        -- use "frabjous/knap"
        use "lervag/vimtex"

        -- gpt - 3
        -- use "jackMort/ChatGPT.nvim"
        -- use "MunifTanjim/nui.nvim"

end)
