local strutils = require("cluautils.string_utils")

---@class ObsidianModule
---@field vaults string[]
local M = {}

---@param vault string
local function openVault(vault)
   local osname
   local openCmd

   local fh = assert(io.popen("uname -o 2>/dev/null","r"))
   if fh then
      osname = fh:read()
   end

   if not osname then
      vim.notify(
         "Unsupported OS used",
         vim.log.levels.WARN
      )
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

local function completion(filter)
   if not filter or strutils.isEmpty(filter) then
      return M.vaults
   end

   local filteredVaults = {}

   for _, vault in ipairs(M.vaults) do
      local s = string.find(vault, filter)

      if s then
         table.insert(filteredVaults, vault)
      end
   end

   return filteredVaults
end

---@param vaults string[]
function M.setup(vaults)
   M.vaults = vaults

   local opts = {
      desc = "Obsidian repositories navigation",
      complete = completion,
      nargs = 1,
   }

   vim.api.nvim_create_user_command("Obsidian", function(args)
      openVault(args.args)
   end, opts)
end

return M
