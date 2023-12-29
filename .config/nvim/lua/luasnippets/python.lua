return {
    s("debug", {
        t('print(f"{'),
        i(0, "()"),
        t(' = }")'),
    }),
    s("function", {
        t("def "),
        i(1, "NAME"),
        t("("),
        i(2, "ARGS"),
        t(") -> "),
        i(3, "RETURN"),
        t(":"),
        isn(4, {
            t({ "", '"""', "" }),
            i(1, "DESCRIPTION"),
            t({ "", "" }),
            i(2, ""),
            t({ '"""', "" }),
        }, "    "),
        i(0),
    }),
}
