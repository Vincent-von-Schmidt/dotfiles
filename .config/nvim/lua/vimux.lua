local M = {}

---@param command string command to execute on term start
function M.term_right(command)
    local buf_nr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_open_win(buf_nr, true, {
        split = "right",
        win = 0,
    })

    vim.fn.termopen(command or "zsh")
end

---@param command string command to execute on term start
function M.term_bottom(command)
    local buf_nr = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_open_win(buf_nr, true, {
        split = "below",
        win = 0,
    })

    vim.fn.termopen(command or "zsh")
end

vim.keymap.set("n", "<leader>o", function()
    M.term_right()
end, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>p", function()
    M.term_bottom()
end, { silent = true, noremap = true })

vim.keymap.set(
    "t",
    "<leader>o",
    '<c-\\><c-n> :lua require("vimux").term_right() <CR>',
    { silent = true, noremap = true }
)

vim.keymap.set(
    "t",
    "<leader>p",
    '<c-\\><c-n> :lua require("vimux").term_bottom() <CR>',
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>x", ":q!<CR>", { silent = true, noremap = true })
vim.keymap.set("t", "<leader>x", "<c-\\><c-n> :q!<CR>", { silent = true, noremap = true })

vim.keymap.set("t", "<c-w>h", "<c-\\><c-n> <c-w>h", { silent = true, noremap = true })
vim.keymap.set("t", "<c-w>j", "<c-\\><c-n> <c-w>j", { silent = true, noremap = true })
vim.keymap.set("t", "<c-w>k", "<c-\\><c-n> <c-w>k", { silent = true, noremap = true })
vim.keymap.set("t", "<c-w>l", "<c-\\><c-n> <c-w>l", { silent = true, noremap = true })

local terminal = vim.api.nvim_create_augroup("tt", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = terminal,
    callback = function()
        vim.cmd([[

            setlocal cursorline

        ]])
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = terminal,
    callback = function()
        vim.cmd([[

            setlocal nocursorline

        ]])
    end,
})

return M
