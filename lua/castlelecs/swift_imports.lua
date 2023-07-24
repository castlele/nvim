local function get_selected_lines(from, to)
    if to < from then
        from, to = to, from
    end

    local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, false)

    return lines
end

local table_contains = require('utils').contains

local function swap_lines(from, to, lines)
    if not table_contains(lines, "import") then
        return
    end

    vim.api.nvim_buf_set_lines(0, from - 1, to, false, lines)
end

--[[--
If some range was selected and there are import statements, those statements is sorted in alphabetical order.
File type should be equal to swift.
]]
function SSImports()
    if vim.bo.filetype ~= "swift" then
        return
    end

    local from = vim.fn.getpos("'<")[2]
    local to = vim.fn.getpos("'>")[2]

    if from == nil or to == nil then
        return
    end

    local lines = get_selected_lines(from, to)

    table.sort(lines)

    swap_lines(from, to, lines)
end

vim.api.nvim_create_user_command("SSImports", SSImports, { desc = "sorting swift imports" })

-- MARK: Keybindings
local post = "<CR>"
local k = require('utils').keymap

k("v", "ssi", ":<C-U>SSImports" .. post)
