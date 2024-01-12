local M = {}

function M.split(input_string, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t = {}
    for str in string.gmatch(input_string, "([^" .. seperator .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function M.trim(input_string)
    return string.gsub(input_string, "%s+", "")
end

return M
