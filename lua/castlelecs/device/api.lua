---@class DeviceManagerApi
local M = {}

---@private
local _M = {}

---@param algorithm "os"
---@param devices Device[]
---@return table<string, Device[]>
function M.sort(algorithm, devices)
   local result

   if algorithm == "os" then
      result = _M.sortByOS(devices)
   end

   return result
end

---@class Device
---@field name string
---@field id string
---@field status string
---@field os "android"|"ios"
---@field osVersion string
---@param callback fun(devices: Device[])
function M.getAll(callback)
   ---@type fun(devices: Device[]?)
   local getAndroidDevices = function(devices)
      devices = devices or {}

      _M.getAndroidDevices(function(androidDevices)
         for _, androidDevice in ipairs(androidDevices) do
            table.insert(devices, androidDevice)
         end

         callback(devices)
      end)
   end

   if require("utils.os").isDarwin() then
      _M.getIosDevices(getAndroidDevices)
   else
      getAndroidDevices()
   end
end

---@param device Device
---@param callback fun()
function M.boot(device, callback)
   if device.os == "ios" then
      _M.bootIosDevice(device, callback)
   else
      _M.bootAndroidDevice(device, callback)
   end
end

---@param device Device
---@param callback fun()
function M.shutdown(device, callback)
   if device.os == "ios" then
      _M.shutdownIosDevice(device, callback)
   else
      _M.shutdownAndroidDevice(device, callback)
   end
end

---@private
---@param callback fun(devices: Device[])
function _M.getIosDevices(callback)
   vim.system({
      "xcrun",
      "simctl",
      "list",
      "devices",
      "available",
      "--json",
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

---@private
---@param callback fun(devices: Device[])
function _M.getAndroidDevices(callback)
   if vim.fn.executable("avdmanager") == 0 then
      vim.schedule(function()
         require("utils").throwError(
            "No avdmanager cmdline tool available. You can't get an access to the android devices"
         )
      end)
      callback {}
      return
   end

   vim.system({
      "avdmanager",
      "list",
      "avd",
   }, {
      text = true,
      timeout = 3000,
   }, function(res)
      if _M.throwIfNeeded(res, "Got an error during avdmanager run") then
         callback {}
         return
      end

      ---@type Device[]
      local devices = {}
      ---@type string?
      local currentName

      _M.getAndroidDeviceId(function(running)
         for line in res.stdout:gmatch("[^\r\n]+") do
            local name = line:match("Name:%s*(.+)$")

            if name then
               currentName = name
               local info = running[name] or {}

               table.insert(devices, {
                  name = name,
                  os = "android",
                  id = info.id or "",
                  status = info.status or "Shutdown",
                  osVersion = "",
               })
            end

            local basedOn = line:match("Based on:%s*(.+)$")

            if currentName and basedOn then
               local androidVersion = basedOn:match("Android%s+API%s+(%d+)")

               devices[#devices].osVersion = "API " .. androidVersion
               currentName = nil
            end
         end

         callback(devices)
      end)
   end)
end

---@private
---@param callback fun(running: table<string, table<string, string>>)
function _M.getAndroidDeviceId(callback)
   vim.system({ "adb", "devices" }, { text = true }, function(res)
      if _M.throwIfNeeded(res, "Got an error during adb devices call") then
         callback {}
         return
      end

      local ids = {}

      for line in res.stdout:gmatch("[^\r\n]+") do
         if not line:match("List of devices") then
            local id, _ = line:match("(%S+)%s+(%S+)")

            if id then
               table.insert(ids, id)
            end
         end
      end

      if #ids == 0 then
         callback {}
         return
      end

      local running = {}
      local passed = {}

      for _, id in ipairs(ids) do
         _M.getDeviceNameById(id, function(name)
            table.insert(passed, id)

            if name then
               running[name] = {
                  status = "Booted",
                  id = id,
               }
            end

            if #passed == #ids then
               callback(running)
            end
         end)
      end
   end)
end

---@private
---@param id string
---@param callback fun(name: string?)
function _M.getDeviceNameById(id, callback)
   vim.system(
      { "adb", "-s", id, "emu", "avd", "name" },
      { text = true },
      function(res)
         if
            _M.throwIfNeeded(
               res,
               "Got an error during adb -s emu avd name call"
            )
         then
            callback(nil)
            return
         end

         local name = res.stdout:match("[^\r\n]+")

         if not name or #name == 0 then
            callback(nil)
            return
         end

         callback(name)
      end
   )
end

---@private
---@param device Device
---@param callback fun()
function _M.bootAndroidDevice(device, callback)
   vim.system(
      { "emulator", "-avd", device.name, "-wipe-data", "-no-snapshot" },
      { text = true },
      function(res)
         if _M.throwIfNeeded(res, "Got an error during emulator -avd call") then
            return
         end

         callback()
      end
   )
end

---@private
--- Running step by step:
--- xcrun simctl boot uuid
--- open -a 'Simulator' --args -CurrentDeviceUDID uuid
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

---@private
---@param device Device
---@param callback fun()
function _M.shutdownAndroidDevice(device, callback)
   vim.system(
      { "adb", "-s", device.id, "emu", "kill" },
      { text = true },
      function(res)
         if _M.throwIfNeeded(res, "Got an error during shutdown") then
            return
         end

         callback()
      end
   )
end

---@private
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

---@private
---@param devices Device[]
---@return table<string, Device[]>
function _M.sortByOS(devices)
   local result = {}

   for _, device in ipairs(devices) do
      local osDevices = result[device.os] or {}

      table.insert(osDevices, device)
      result[device.os] = osDevices
   end

   return result
end

---@private
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
