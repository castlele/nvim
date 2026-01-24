---@class DeviceManager
---@field mainWin Window
---@field devices Device[]
local M = {}

---@class Window
---@field buf integer
---@field win integer
---@field width integer
---@field height integer

---@param bufn integer?
---@param opts vim.api.keyset.win_config?
---@return Window
local function openFloatingWindow(bufn, opts)
   opts = opts or {}

   opts.width = opts.width or vim.o.columns
   opts.height = opts.height or vim.o.lines
   opts.relative = opts.relative or "editor"

   if not bufn or not vim.api.nvim_buf_is_loaded(bufn) then
      bufn = vim.api.nvim_create_buf(false, true)
   end

   local win = vim.api.nvim_open_win(bufn, true, opts)

   return {
      buf = bufn,
      win = win,
      width = opts.width,
      height = opts.width,
   }
end

---@return vim.api.keyset.win_config
local function createMainWindowConfig()
   local width = math.floor(vim.o.columns * 0.8)
   local height = math.floor(vim.o.lines * 0.8)

   local col = math.floor((vim.o.columns - width) / 2)
   local row = math.floor((vim.o.lines - height) / 2)

   return {
      relative = "editor",
      width = width,
      height = height,
      col = col,
      row = row,
      style = "minimal",
      border = "rounded",
   }
end

local function setKeymaps()
   vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(M.mainWin.win, false)
   end, {
      buffer = M.mainWin.buf,
   })
end

local ns = vim.api.nvim_create_namespace("device-manager")

local function setHighlighting()
   local id = vim.api.nvim_get_hl_id_by_name("Normal")
   local normal = vim.api.nvim_get_hl(id, {})

   vim.api.nvim_set_hl(0, "IosHeader", {
      bold = true,
      fg = normal.fg,
      bg = "#5ac8fa",
   })

   vim.api.nvim_set_hl(0, "RowOS", { link = "Comment" })
   vim.api.nvim_set_hl(0, "SuspendedRowStatus", { link = "Error" })
end

local function hl_range(row, startColumn, endColumn, group)
   vim.api.nvim_buf_set_extmark(M.mainWin.buf, ns, row, startColumn, {
      end_row = row,
      end_col = endColumn,
      hl_group = group,
      priority = 200,
   })
end

local function draw()
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
            name = "RowOS",
         })

         if device.status == "Shutdown" then
            local lhs = #deviceNameWithOS + #spacing

            table.insert(hi, {
               row = index,
               startCol = lhs,
               endCol = lhs + #status,
               name = "SuspendedRowStatus",
            })
         end
      end

      vim.bo[M.mainWin.buf].modifiable = true

      vim.api.nvim_buf_set_lines(M.mainWin.buf, 0, -1, false, lines)

      vim.bo[M.mainWin.buf].modifiable = false

      hl_range(0, 0, 3, "IosHeader")

      for _, h in ipairs(hi) do
         hl_range(h.row, h.startCol, h.endCol, h.name)
      end
   end)
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
         local configUpdated = createMainWindowConfig()

         vim.api.nvim_win_set_config(M.mainWin.win, configUpdated)
         M.mainWin.width = configUpdated.width
         M.mainWin.height = configUpdated.height

         draw()
      end,
   })
end

---@class Device
---@field name string
---@field id string
---@field status string
---@field os "android"|"ios"
---@field osVersion string
---@param callback fun(devices: Device[])
local function getIosDevices(callback)
   vim.system({
      "xcrun",
      "simctl",
      "list",
      "devices",
      "available",
      "--j",
   }, {
      text = true,
   }, function(res)
      if res.code ~= 0 then
         require("utils").throwError(
            "Got an error during xcrun simctl command: "
               .. (res.stderr or res.stdout or res.code)
         )
         callback {}
      end

      local osToDevices = vim.json.decode(res.stdout).devices
      ---@type Device[]
      local devices = {}

      for os, rawDevices in pairs(osToDevices) do
         os = require("utils.string").lastAfter(os, ".")

         for _, device in ipairs(rawDevices) do
            table.insert(devices, {
               os = "ios",
               name = device.name,
               id = device.udid,
               status = device.state,
               osVersion = os,
            })
         end
      end

      callback(devices)
   end)
end

local function deviceManagerCommand()
   M.mainWin = openFloatingWindow(nil, createMainWindowConfig())

   setKeymaps()
   setAutoCmd()

   getIosDevices(function(devices)
      M.devices = devices
      draw()
   end)
end

local function setup()
   setHighlighting()
   vim.api.nvim_create_user_command("DM", deviceManagerCommand, {})
end

-- xcrun simctl boot
-- open -a 'Simulator' --args -CurrentDeviceUDID

return {
   setup = setup,
}
