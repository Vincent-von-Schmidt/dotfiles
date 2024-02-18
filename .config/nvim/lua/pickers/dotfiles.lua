local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

local dotfiles = {
    ["neovim"] = "cd ~/.config/nvim/ | Telescope find_files",
    ["windows_terminal"] =
    "edit /mnt/c/Users/Vincent/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json",
    ["powershell"] = "edit /mnt/c/Users/Vincent/Documents/PowerShell/Microsoft.PowerShell_profile.ps1",
    ["tmux"] = "edit ~/.config/tmux/tmux.conf",
    ["zsh"] = "edit ~/.zshrc",
    ["bash"] = "edit ~/.bashrc",
}

local function map_keys(map)
    local keys = {}
    for k, _ in pairs(map) do
        table.insert(keys, k)
    end
    return keys
end

local dotfiles_picker = function(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "dotfiles",
            finder = finders.new_table({
                results = map_keys(dotfiles),
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd(dotfiles[selection[1]])
                end)
                return true
            end,
        })
        :find()
end

-- to execute the function
dotfiles_picker()
