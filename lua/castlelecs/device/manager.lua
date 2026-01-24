---@class DeviceManager
---@field mainWin Window
---@field devices Device[]
---@field api DeviceManagerApi
---@field config DeviceManagerConfig
local M = {}

function M.draw()
   vim.schedule(function()
      ---@type string[]
      local lines = { "iOS" }
      local hi = {}

      for index, device in ipairs(M.devices) do
         local deviceName = string.format("   %i. %s ", index, device.name)
         local deviceNameWithOS = deviceName .. device.osVersion
         local status = string.format("(%s) ", device.status)

         local spacing =
            string.rep(" ", M.mainWin.width - #deviceNameWithOS - #status)

         table.insert(
            lines,
            string.format("%s%s%s", deviceNameWithOS, spacing, status)
         )

         table.insert(hi, {
            row = index,
            startCol = #deviceName,
            endCol = #deviceNameWithOS,
            name = M.config.hi.RowOS,
         })

         if device.status == "Shutdown" then
            local lhs = #deviceNameWithOS + #spacing

            table.insert(hi, {
               row = index,
               startCol = lhs,
               endCol = lhs + #status,
               name = M.config.hi.SuspendedRowStatus,
            })
         end
      end

      vim.bo[M.mainWin.buf].modifiable = true

      vim.api.nvim_buf_set_lines(M.mainWin.buf, 0, -1, false, lines)

      vim.bo[M.mainWin.buf].modifiable = false

      M.config.highlightRange(M.mainWin.buf, 0, 0, 3, M.config.hi.IosHeader)

      for _, h in ipairs(hi) do
         M.config.highlightRange(
            M.mainWin.buf,
            h.row,
            h.startCol,
            h.endCol,
            h.name
         )
      end
   end)
end

function M.updateDevices()
   M.api.getIosDevices(function(devices)
      M.devices = devices
      M.draw()
   end)
end

---@return Device?
function M.getCurrentDevice()
   local row = vim.api.nvim_win_get_cursor(M.mainWin.win)[1] - 1

   if row < 1 or row > M.mainWin.height then
      return nil
   end

   return M.devices[row]
end

local function setAutoCmd()
   vim.api.nvim_create_autocmd("WinLeave", {
      buffer = M.mainWin.buf,
      callback = function()
         vim.api.nvim_win_close(M.mainWin.win, false)
      end,
   })

   vim.api.nvim_create_autocmd("VimResized", {
      buffer = M.mainWin.buf,
      callback = function()
         local configUpdated = M.config.createMainWindowConfig()

         vim.api.nvim_win_set_config(M.mainWin.win, configUpdated)
         M.mainWin.width = configUpdated.width
         M.mainWin.height = configUpdated.height

         M.draw()
      end,
   })
end

local function setKeymaps()
   vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(M.mainWin.win, false)
   end, {
      buffer = M.mainWin.buf,
   })

   vim.keymap.set("n", "<Enter>", function()
      local device = M.getCurrentDevice()

      if not device then
         return
      end

      M.api.boot(device, function()
         M.updateDevices()
      end)
   end, {
      buffer = M.mainWin.buf,
   })

   vim.keymap.set("n", "x", function()
      local device = M.getCurrentDevice()

      if not device then
         return
      end

      M.api.shutdown(device, function()
         M.updateDevices()
      end)
   end, {
      buffer = M.mainWin.buf,
   })
end

local function deviceManagerCommand()
   M.config = require("castlelecs.device.config")
   M.api = require("castlelecs.device.api")
   M.mainWin = require("utils.window").openFloatingWindow(
      nil,
      M.config.createMainWindowConfig()
   )

   setKeymaps()
   setAutoCmd()

   M.updateDevices()
end

local function setup()
   (M.config or require("castlelecs.device.config")).setHighlighting()
   vim.api.nvim_create_user_command("DM", deviceManagerCommand, {})
end

return {
   setup = setup,
}
