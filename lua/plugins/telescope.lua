---@class TelescopeConfiguratorModule
local M = {}

---@class TelescopeConfiguratorModuleConfig
---@field keymaps table?
---@field telescopeBufferKeymaps table?
---@field setup (fun(mappings: string))?
---@field loadExtensions (fun())?
function M.setup(config)
   local utils = require("utils")
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

   utils.setKeymaps(keymaps)
end

return M
