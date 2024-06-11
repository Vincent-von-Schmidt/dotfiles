local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

local M = {}

local action = {
    ["files"] = "Telescope find_files",
    ["terminal"] = 'lua vim.fn.termopen("bash")',
}

function M.picker(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "launcher",
            finder = finders.new_table({
                results = require("utils.map").map_keys(action),
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd(action[selection[1]])
                end)
                return true
            end,
        })
        :find()
end

return M
