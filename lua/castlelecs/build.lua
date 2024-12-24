local FM = require("cluautils.file_manager")

local M = {}
local buildFile = "build.lua"
local generateCommand = "generate"

local function editBuildFile()
   vim.cmd("vsplit")
   vim.cmd("edit " .. buildFile)
end

local defaultCommands = {
   edit = editBuildFile,
   generate = function ()
      if FM.is_file_exists(buildFile) then
         vim.notify(
            "Your build.lua file is already generated. You can edit it with `:Build edit` command",
            vim.log.levels.WARN
         )
         return
      end

      FM.create_file(buildFile)
      FM.write_to_file(buildFile, "w", function ()
         return [[
conf = {
}]]
      end)

      editBuildFile()
   end,
}

---@return boolean
local function reloadConfigurationFile()
   local fun, error = loadfile(buildFile)

   if error then
      vim.notify(error, vim.log.levels.ERROR)
      return false
   end

   if fun then
      pcall(fun)
   end

---@diagnostic disable-next-line
   return conf ~= nil
end

---@return table
local function getAvailableConfigurations()
   if not reloadConfigurationFile() then
      return defaultCommands
   end

   local configurations = {}

---@diagnostic disable-next-line
   for name, _ in pairs(conf) do
      table.insert(configurations, name)
   end

   for name, _ in pairs(defaultCommands) do
      table.insert(configurations, name)
   end

   return configurations
end

---@param configurations table
---@param command string
---@return (fun(): string)?
local function getCodeAsFunction(configurations, command)
   if not configurations[command] then
      return nil
   end

   return function () return configurations[command] end
end


---@param command string
---@return (fun(): string)?
function M.build(command)
   if not reloadConfigurationFile() then
      return nil
   end

   ---@diagnostic disable-next-line
   local fun = getCodeAsFunction(conf, command) or defaultCommands[command]

   if not fun then
      vim.notify(
         "Can't find command '" .. command .. "'",
         vim.log.levels.WARN
      )
      return nil
   end

   return fun
end

function M.completion()
   return getAvailableConfigurations()
end


return M
