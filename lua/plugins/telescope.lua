local utils = require("utils")

---@class TelescopeConfiguratorModule
local M = {}

---@class TelescopeConfiguratorModuleConfig
---@field keymaps table?
---@field telescopeBufferKeymaps table?
---@field setup (fun(mappings: string))?
---@field loadExtensions (fun())?
function M.setup(config)
   local keymaps = config.keymaps

   if config.setup then
      config.setup(config.telescopeBufferKeymaps or {})
   end

   if config.loadExtensions then
      config.loadExtensions()
   end

   if not keymaps then
      return
   end

   for mode, combs in pairs(keymaps) do
      assert(type(mode) == "string")
      assert(type(combs) == "table")

      for key, fun in pairs(combs) do
         assert(type(key) == "string")
         assert(type(fun) == "function")

         utils.keymap_func(mode, key, fun)
      end
   end
end

return M
