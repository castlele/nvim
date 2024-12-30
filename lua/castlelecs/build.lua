local FM = require("cluautils.file_manager")
require("cluautils.string_utils")

local M = {}
local buildFile = "build.lua"

local function editBuildFile()
   vim.cmd("vsplit")
   vim.cmd("edit " .. buildFile)
end

local defaultCommandsAsStr = {
   edit = [[
vim.cmd("vsplit")
vim.cmd("edit " .. buildFile)
   ]],
   generate = "Generating build.lua in the root folder :)"
}

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
   local fun, _ = loadfile(buildFile)

   if fun then
      pcall(fun)
   end

---@diagnostic disable-next-line
   return conf ~= nil
end

---@return table
local function getAvailableConfigurations()
   reloadConfigurationFile()

   local configurations = {}

   ---@diagnostic disable-next-line
   if conf then
      ---@diagnostic disable-next-line
      for name, _ in pairs(conf) do
         table.insert(configurations, name)
      end
   end

   for name, _ in pairs(defaultCommands) do
      table.insert(configurations, name)
   end

   return configurations
end

---@param configurations table?
---@param command string
---@return (fun(): string)?
local function getCodeAsFunction(configurations, command)
   if not configurations or not configurations[command] then
      return nil
   end

   return function () return configurations[command] end
end


---@param command string
---@return (fun(): string)?
function M.buildInTerm(command)
   local term = require('toggleterm.terminal').Terminal
   local fun = M.build(command)

   if not fun then
      return
   end

   local terminalCommand = fun()

   if not terminalCommand then
      return
   end

   term:new {
      direction = "horizontal",
      cmd = terminalCommand,
      display_name = command,
      hidden = false,
      close_on_exit = false,
   }:toggle()
end

---@param command string
---@return (fun(): string)?
function M.build(command)
   reloadConfigurationFile()

   ---@diagnostic disable-next-line
   local cmd = string.trim(command)

   ---@diagnostic disable-next-line
   local fun = getCodeAsFunction(conf, cmd) or defaultCommands[cmd]

   if not fun then
      vim.notify(
         "Can't find command '" .. cmd .. "'",
         vim.log.levels.WARN
      )
      return nil
   end

   return fun
end

---@param command string
---@return string?
function M.asString(command)
   if not defaultCommands[command] then
      return M.build(command)()
   end

   return defaultCommandsAsStr[command]
end

function M.completion(completion)
   local configurations = getAvailableConfigurations()

   if not completion or string.is_empty(completion) then
      return configurations
   end

   local filteredConf = {}

   for _, configuration in ipairs(configurations) do
      local s = string.find(configuration, completion)

      if s then
         table.insert(filteredConf, configuration)
      end
   end

   return filteredConf
end


return M
