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
function M.open_term(command)
    local width, height = 150, 30
    local buf_nr, _ = M.create(util_string.split(command, " ")[1], width, height)

    vim.api.nvim_open_term(buf_nr, {
        on_input = vim.api.nvim_chan_send(vim.fn.termopen(command), ""),
    })
end

return M
