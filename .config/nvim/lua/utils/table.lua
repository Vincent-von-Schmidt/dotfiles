local M = {}

---@param tb table table to print
function M.print(tb)
    print("------")
    for _, el in pairs(tb) do
        print(el)
    end
    print("------")
end

return M
