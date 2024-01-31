local M = {}

---@param mode string vim mode
---@param key string key to press
---@param map string|function behaviour on press
---@param opts table|nil keymap opts
---@return string
function M.keymap(mode, key, map, opts)
    vim.keymap.set(mode, key, map, opts or { silent = true, noremap = true })
    return key -- lazy
end

---@param key string key to press
---@param map string|function behaviour on press
---@param opts table|nil keymap opts
---@return table
function M.lazy_keymap(key, map, opts)
    return { key, map, opts or { silent = true, noremap = true } }
end

---@param group string vim highlight group
---@param hl table the highlight as lua table
function M.highlight(group, hl)
    vim.api.nvim_set_hl(0, group, hl)
end

return M
