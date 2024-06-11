return {
    -- {
    --     "nosduco/remote-sshfs.nvim",
    --     dependencies = {
    --         "nvim-telescope/telescope.nvim",
    --         "nvim-lua/plenary.nvim",
    --     },
    --     lazy = true,
    --     cmd = "RemoteSSHFSConnect",
    --     config = function()
    --         require("remote-sshfs").setup({
    --             handlers = {
    --                 on_disconnect = {
    --                     clean_mount_folders = true,
    --                 },
    --             },
    --         })
    --         require("telescope").load_extension("remote-sshfs")
    --
    --         vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    --             callback = function()
    --                 vim.cmd("RemoteSSHFSDiconnect")
    --             end,
    --         })
    --     end,
    -- },
    {
        "amitds1997/remote-nvim.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
        cmd = {
            "RemoteStart",
            "RemoteStop",
            "RemoteInfo",
            "RemoteCleanup",
            "RemoteConfigDel",
            "RemoteLog",
        },
        config = function()
            require("remote-nvim").setup()
        end,
    },
}
