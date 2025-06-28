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

---@param keymaps table
function M.setKeymaps(keymaps)
   for mode, combs in pairs(keymaps) do
      assert(type(mode) == "string")
      assert(type(combs) == "table")

      for key, fun in pairs(combs) do
         assert(type(key) == "string")
         assert(type(fun) == "function")

         M.keymap_func(mode, key, fun)
      end
   end
end

return M
