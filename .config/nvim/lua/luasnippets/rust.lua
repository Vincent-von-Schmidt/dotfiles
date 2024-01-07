return {
    s("debug", {
        t('println!("{:?}", '),
        i(0, "()"),
        t(");"),
    }),
    -- s("debug", {
    --     t('println!("'),
    --     f(function(args)
    --         return args[1][1]
    --     end, { 0 }),
    --     t(' = {:?}", '),
    --     i(0, "()"),
    --     t(");"),
    -- }),
}
