return {
    "nosduco/remote-sshfs.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    cmd = "RemoteSSHFSConnect",
    config = function()
        require("remote-sshfs").setup({})
        require("telescope").load_extension("remote-sshfs")
    end,
}
