local util_string = require("utils.string")
local k = require("luasnip.nodes.key_indexer").new_key

return {
    s("function", {
        d(3, function(args)
            local output = {}
            local jump_index = 1

            -- args
            local arguments = util_string.split(args[1][1], ",")
            for _, el in ipairs(arguments) do
                local declaration_split = util_string.split(el, " ") -- name, type
                local var_name = declaration_split[1]

                table.insert(output, t("---@param " .. var_name .. " "))
                table.insert(output, i(jump_index))
                table.insert(output, t(" "))
                table.insert(output, i(jump_index + 1))
                table.insert(output, t({ "", "" }))

                jump_index = jump_index + 2
            end

            return sn(nil, output)
        end, { k("args-key") }),
        t({ "function " }),
        i(1, "NAME"),
        t("("),
        i(2, "ARGS", { key = "args-key" }),
        t({ ")", "    " }),
        i(0),
        t({ "", "end" }),
    }),
}
