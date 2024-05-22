local tabs = vim.fn.tabpagebuflist()
for el, _ in ipairs(tabs) do
    print(el)
end

vim.ui.select({ "foo", "bar" }, {
    prompt = "Title",
}, function(item)
    print(item)
end)
