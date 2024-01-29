return {
    "mbbill/undotree",
    lazy = true,
    keys = {
        { "<leader>u", ":UndotreeToggle <CR> :UndotreeFocus <CR>", silent = true },
    },
    config = function()
        vim.g.undotree_WindowLayout = 4
    end,
}
