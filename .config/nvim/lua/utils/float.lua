local util_string = require("utils.string")
local M = {}

---@param title string window title
---@param width integer width of the floating window
---@param height integer height of the floating window
---@return number[]
function M.create(title, width, height)
    local buf_nr = vim.api.nvim_create_buf(false, true)

    local win_id = vim.api.nvim_open_win(buf_nr, true, {
        relative = "editor",
        title = title,
        title_pos = "left",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor(((vim.o.lines - height) / 2) - 1),
        style = "minimal",
        border = "single",
    })

    return { buf_nr, win_id }
end

---@param command string command to execute on term start
function M.term(command)
    local title = util_string.split(command, " ")[1] -- first word of command
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    M.create(title, width, height)
    vim.fn.termopen(command)
end

return M
