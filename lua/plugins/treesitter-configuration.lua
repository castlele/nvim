---@class TreesitterConfModule
local M = {}

---@class TreesitterConfModuleConfig
---@field languages table<string>?
---@param config TreesitterConfModuleConfig
function M.setup(config)
   ---@diagnostic disable-next-line
   require("nvim-treesitter.configs").setup {
      ensure_installed = config.languages or {},
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
   }
end

return M
