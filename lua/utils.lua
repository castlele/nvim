local M = {}

function M.keymap(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

function M.contains(table, x)
    for _, v in pairs(table) do
        if string.find(v, x) then
            return true
        end
    end

    return false
end

return M
