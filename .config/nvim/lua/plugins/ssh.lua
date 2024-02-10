return {
    "nosduco/remote-sshfs.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    cmd = "RemoteSSHFSConnect",
    config = function()
        require("remote-sshfs").setup({
            handlers = {
                on_disconnect = {
                    clean_mount_folders = true,
                },
            },
        })
        require("telescope").load_extension("remote-sshfs")
    end,
}
