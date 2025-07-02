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

function M.throwError(msg)
   vim.notify(msg, vim.log.levels.ERROR)
end

---@param filter string
---@param variants table[string]
---@return table[string]
function M.completion(filter, variants)
   if not filter or #filter == 0 then
      return variants
   end

   local filteredVariants = {}

   for _, variant in ipairs(variants) do
      local s = string.find(variant, filter)

      if s then
         table.insert(filteredVariants, variant)
      end
   end

   return filteredVariants
end

return M
