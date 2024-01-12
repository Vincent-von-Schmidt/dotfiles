local util_string = require("utils.string")
local k = require("luasnip.nodes.key_indexer").new_key

return {
    s("debug", {
        t('println!("{:?}", '),
        i(0, "()"),
        t(");"),
    }),
    s("function", {
        isn(4, {
            t({ "", "" }),
            i(1, "DESC"),
            t({ "", "", "" }),
            d(2, function(args)
                local output = {}
                local jump_index = 1

                -- args
                local arguments = util_string.split(args[1][1], ",")
                for _, el in ipairs(arguments) do
                    local declaration_split = util_string.split(el, ": ") -- name, type

                    table.insert(output, t("* `" .. declaration_split[1] .. "` - "))
                    table.insert(output, i(jump_index))
                    table.insert(output, t({ "", "" }))

                    jump_index = jump_index + 1
                end

                return sn(nil, output)
            end, { k("args-key") }),
            t({ "" }),
        }, "/// "),
        t({ "", "fn " }),
        i(1, "NAME"),
        t("("),
        i(2, "ARGS", { key = "args-key" }),
        t(") -> "),
        i(3, "RETURN"),
        t({ "", "{" }),
        isn(5, {
            t(""),
            i(0),
            t(""),
        }, "    "),
        t({ "", "}" }),
    }),
}
