local utils = {}

function utils.keymap(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

return utils
