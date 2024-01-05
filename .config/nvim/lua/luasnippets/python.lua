local k = require("luasnip.nodes.key_indexer").new_key

local function string_trim(input_string)
    return string.gsub(input_string, "%s+", "")
end

local function split_string(input_string, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t = {}
    for str in string.gmatch(input_string, "([^" .. seperator .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return {
    s("debug", {
        t('print(f"{'), i(0, "()"), t(' = }")'),
    }),
    s("function", {
        t("def "), i(1, "NAME"), t("("), i(2, "ARGS", { key = "args-key" }), t(") -> "),
        i(3, "RETURN", { key = "return-key" }), t(":"),
        isn(4, {
            t({ "", '"""', "" }),
            i(1, "DESC"),
            t({ "", "", "" }),
            d(2, function(args)
                -- TODO -> trim string
                local output = {}
                local jump_index = 1

                -- args
                local arguments = split_string(args[1][1], ",")
                for _, el in ipairs(arguments) do
                    local declaration_split = split_string(el, ":") -- name, type

                    table.insert(output, t(string.format(":param %s %s: ", declaration_split[2], declaration_split[1])))
                    table.insert(output, i(jump_index))
                    table.insert(output, t { "", "" })

                    jump_index = jump_index + 1
                end

                -- return
                local returns = args[2][1]
                table.insert(output, t({ "", string.format(":return %s: ", returns) }))
                table.insert(output, i(jump_index))

                return sn(nil, output)
            end, { k("args-key"), k("return-key") }),
            t({ "", '"""', "" }),
        }, "    "),
    }),
}
