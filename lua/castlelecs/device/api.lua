---@class DeviceManagerApi
local M = {}
---@private
local _M = {}

---@class Device
---@field name string
---@field id string
---@field status string
---@field os "android"|"ios"
---@field osVersion string
--- TODO: Convert to private methdo. update to return both adr/ios
---@param callback fun(devices: Device[])
function M.getIosDevices(callback)
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
      if
         _M.throwIfNeeded(res, "Got an error during xcrun simctl command: ")
      then
         callback {}
         return
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

---@param device Device
---@param callback fun()
function M.boot(device, callback)
   if device.os == "ios" then
      _M.bootIosDevice(device, callback)
   else
      ---@diagnostic disable-next-line: missing-fields
      _M.throwIfNeeded({ code = -1 }, "Unsupported device os: " .. device.os)
   end
end

---@param device Device
---@param callback fun()
function M.shutdown(device, callback)
   if device.os == "ios" then
      _M.shutdownIosDevice(device, callback)
   else
      ---@diagnostic disable-next-line: missing-fields
      _M.throwIfNeeded({ code = -1 }, "Unsupported device os: " .. device.os)
   end
end

--- Running step by step:
--- xcrun simctl boot uuid
--- open -a 'Simulator' --args -CurrentDeviceUDID uuid
---@private
---@param device Device
---@param callback fun()
function _M.bootIosDevice(device, callback)
   local open = function(onExitCallback)
      vim.system({
         "open",
         "-a",
         "Simulator",
         "--args",
         "-CurrentDeviceUDID",
         device.id,
      }, { text = true }, function(res)
         if _M.throwIfNeeded(res, "Got an error during simulator opening") then
            return
         end

         onExitCallback()
      end)
   end

   local boot = function(onBootedCallback)
      vim.system(
         { "xcrun", "simctl", "boot", device.id },
         { text = true },
         function(res)
            if _M.throwIfNeeded(res, "Got an error during device boot") then
               return
            end

            onBootedCallback(callback)
         end
      )
   end

   boot(open)
end

--- Running step by step:
--- xcrun simctl shutdown uuid
---@param device Device
---@param callback fun()
function _M.shutdownIosDevice(device, callback)
   vim.system(
      { "xcrun", "simctl", "shutdown", device.id },
      { text = true },
      function(res)
         if _M.throwIfNeeded(res, "Got an error during shutdown") then
            return
         end

         callback()
      end
   )
end

---@param res vim.SystemCompleted
---@param msg string
---@return boolean
function _M.throwIfNeeded(res, msg)
   if res.code == 0 then
      return false
   end

   local throw = function()
      require("utils").throwError(
         msg .. ": " .. res.stderr or res.stdout or res.code
      )
   end

   vim.schedule(throw)

   return true
end

return M
