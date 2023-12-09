local M = {}

function M.keymap(mode, lhs, rhs, desc)
   local opts = { noremap = true, silent = true, desc = desc }
   vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

return M
