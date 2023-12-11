local M = {}

local function get_opts(desc)
   return { noremap = true, silent = true, desc = desc }
end

function M.keymap(mode, lhs, rhs, desc)
   vim.api.nvim_set_keymap(mode, lhs, rhs, get_opts(desc))
end

function M.keymap_func(mode, lhs, rhs, desc)
   vim.keymap.set(mode, lhs, rhs, get_opts(desc))
end

return M
