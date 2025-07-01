---@class VaultData
---@field path string path to the vault
---@field res string? path to the resource folder relateive to the `path`
---@field templates string? path to the templates folder relateive to the `path`
---@class ObsidianModule
---@field vaults table[string, VaultData] map where key is vault name and value is its path
local M = {}

---@param vaultName string
---@param templateName string
local function insertTemplate(vaultName, templateName)
   -- vim.api.nvim_buf_set_lines(0, 0, )
end

---@param vaultName string
local function checkoutVault(vaultName)
   local vault = M.vaults[vaultName]

   vim.cmd.tabnew()
   vim.cmd.lcd(vault.path)
end

---@param vaultName string
local function openVault(vaultName)
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

   local command = string.format("%s obsidian://vault/%s", openCmd, vaultName)
   local term = require("toggleterm.terminal").Terminal

   term
      :new({
         cmd = command,
         hidden = true,
         close_on_exit = true,
      })
      :toggle()
end

---@param vaults table[string]|table[VaultData]
---@return table[string, string] map where key is vault name and value is its path
local function parseVaults(vaults)
   ---@type table[string, VaultData]
   local res = {}

   ---@type fun(vault: VaultData)
   local insertVault = function(vault)
      local filePath = vim.fn.expand(vault.path)
      local pathComponents = vim.fn.split(filePath, "/")

      local vaultName = pathComponents[#pathComponents]
      res[vaultName] = vault
   end

   for _, vault in ipairs(vaults) do
      if type(vault) == "string" then
         insertVault {
            path = vault,
         }
      elseif type(vault) == "table" then
         assert(vault.path, "Vault data should contain path property")

         insertVault(vault)
      else
         vim.notify(
            string.format(
               "Obsidian: Unknown vault passed to configuration: %s",
               vim.inspect(vault)
            ),
            vim.log.levels.ERROR
         )
      end
   end

   return res
end

local function completion(filter)
   local vaults = vim.tbl_keys(M.vaults)
   local strutils = require("cluautils.string_utils")

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
---@field vaults table<string>|table<VaultData> paths to the vaults
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

   vim.api.nvim_create_user_command("ObsidianInsertTemplate", function(args)
      insertTemplate(args.fargs[1], args.fargs[2])
   end, {
      desc = "Insert template in the current buffer",
      complete = function(filter, command)
         local commands = vim.split(command, " ")

         if #commands - 1 == 1 then
            return completion(filter)
         elseif #commands - 1 == 2 then
            local vaultName = commands[2]
            local vault = M.vaults[vaultName]

            if not vault.templates then
               return {}
            end

            local templatesPath =
               string.format("%s/%s", vault.path, vault.templates)
            local res = {}

            local fd = io.popen("ls " .. templatesPath)

            if not fd then
               return {}
            end

            for filename in fd:lines() do
               table.insert(res, filename)
            end

            fd:close()

            return res
         else
            return {}
         end
      end,
      nargs = "*",
   })
end

return M
