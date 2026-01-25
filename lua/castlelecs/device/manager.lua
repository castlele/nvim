---@class DeviceManager
---@field mainWin Window
---@field devices Device[]
---@field headerToDevices table<string, Device[]>
---@field api DeviceManagerApi
---@field config DeviceManagerConfig
local M = {}

function M.draw()
   vim.schedule(function()
      ---@type string[]
      local lines = {}
      local hi = {}

      for header, devices in pairs(M.headerToDevices) do
         table.insert(lines, header)

         if header == "ios" then
            table.insert(hi, {
               row = #lines - 1,
               startCol = 0,
               endCol = #header,
               name = M.config.hi.IosHeader,
            })
         elseif header == "android" then
            table.insert(hi, {
               row = #lines - 1,
               startCol = 0,
               endCol = #header,
               name = M.config.hi.AndroidHeader,
            })
         end

         for index, device in ipairs(devices) do
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
               row = #lines - 1,
               startCol = #deviceName,
               endCol = #deviceNameWithOS,
               name = M.config.hi.RowOS,
            })

            if device.status == "Shutdown" then
               local lhs = #deviceNameWithOS + #spacing

               table.insert(hi, {
                  row = #lines - 1,
                  startCol = lhs,
                  endCol = lhs + #status,
                  name = M.config.hi.SuspendedRowStatus,
               })
            end
         end
      end

      vim.bo[M.mainWin.buf].modifiable = true

      vim.api.nvim_buf_set_lines(M.mainWin.buf, 0, -1, false, lines)

      vim.bo[M.mainWin.buf].modifiable = false

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
   M.api.getAll(function(devices)
      M.devices = devices
      M.headerToDevices = M.api.sort("os", M.devices)
      M.draw()
   end)
end

---@return Device?
function M.getCurrentDevice()
   local row = vim.api.nvim_win_get_cursor(M.mainWin.win)[1] - 1

   if row < 1 or row > M.mainWin.height then
      return nil
   end

   local index = 0

   for header, devices in pairs(M.headerToDevices) do
      if index == row then
         return nil
      end

      index = index + 1

      for _, device in ipairs(devices) do
         if index == row then
            return device
         end

         index = index + 1
      end
   end

   return nil
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
