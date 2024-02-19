local M = {}

function M.map_keys(map)
    local keys = {}
    for k, _ in pairs(map) do
        table.insert(keys, k)
    end
    return keys
end

return M
