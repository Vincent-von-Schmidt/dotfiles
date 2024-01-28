local M = {}

---@param mode string vim mode
---@param key string key to press
---@param map string behaviour on press
---@param opts table keymap opts
function M.keymap(mode, key, map, opts)
    local opts = opts or { silent = true, noremap = true }
    vim.keymap.set(mode, key, map, opts)
end

---@param group string vim highlight group
---@param hl table the highlight as lua table
function M.highlight(group, hl)
    vim.api.nvim_set_hl(0, group, hl)
end

---@param name string name of the group
---@param opts table autogroup opts
function M.autogroup(name, opts)
    local opts = opts or { clear = true }
    return vim.api.nvim_create_augroup(name, opts)
end

---@param events string[] events to trigger the autocmd
---@param opts table autocmd opts
function M.autocmd(events, opts)
    vim.api.nvim_create_autocmd(events, opts)
end

return M
