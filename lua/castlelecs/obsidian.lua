local strutils = require("cluautils.string_utils")

---@class ObsidianModule
---@field vaults table[string, string] map where key is vault name and value is its path
local M = {}

---@param vault string
local function checkoutVault(vault)
   local path = M.vaults[vault]

   vim.cmd.tabnew()
   vim.cmd.lcd(path)
end

---@param vault string
local function openVault(vault)
   local osname
   local openCmd

   local fh = assert(io.popen("uname -o 2>/dev/null", "r"))
   if fh then
      osname = fh:read()
   end

   if not osname then
      vim.notify("Unsupported OS used", vim.log.levels.WARN)
   end

   if osname == "GNU/Linux" then
      openCmd = "xdg-open"
   else
      openCmd = "open"
   end

   local command = string.format("%s obsidian://vault/%s", openCmd, vault)
   local term = require("toggleterm.terminal").Terminal

   term
      :new({
         cmd = command,
         hidden = true,
         close_on_exit = true,
      })
      :toggle()
end

---@param vaultsPaths table[string]
---@return table[string, string] map where key is vault name and value is its path
local function parseVaults(vaultsPaths)
   local res = {}

   for _, vaultPath in ipairs(vaultsPaths) do
      local filePath = vim.fn.expand(vaultPath)
      local pathComponents = vim.fn.split(filePath, "/")

      local vaultName = pathComponents[#pathComponents]
      res[vaultName] = vaultPath
   end

   return res
end

local function completion(filter)
   local vaults = vim.tbl_keys(M.vaults)

   if not filter or strutils.isEmpty(filter) then
      return vaults
   end

   local filteredVaults = {}

   for _, vault in ipairs(vaults) do
      local s = string.find(vault, filter)

      if s then
         table.insert(filteredVaults, vault)
      end
   end

   return filteredVaults
end

---@class ObsidianModuleConfig
---@field vaults string[] paths to the vaults
---@param config ObsidianModuleConfig
function M.setup(config)
   M.vaults = parseVaults(config.vaults)

   vim.api.nvim_create_user_command("ObsidianList", function()
      vim.print(M.vaults)
   end, {
      desc = "List of Obsidian vaults",
      nargs = 0,
   })

   vim.api.nvim_create_user_command("Obsidian", function(args)
      openVault(args.args)
   end, {
      desc = "Obsidian repositories navigation",
      complete = completion,
      nargs = 1,
   })

   vim.api.nvim_create_user_command("ObsidianOpen", function(args)
      checkoutVault(args.args)
   end, {
      desc = "Open Obsidian vault in new neovim tab",
      complete = completion,
      nargs = 1,
   })
end

return M
