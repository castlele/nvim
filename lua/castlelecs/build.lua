local FM = require("cluautils.file_manager")

local M = {}
local buildFile = "build.lua"
local generateCommand = "generate"
local commands = {
   generate = function ()
      FM.create_file(buildFile)
      FM.write_to_file(buildFile, "w", function ()
         return [[
conf = {
}]]
      end)
      vim.cmd("vsplit")
      vim.cmd("edit " .. buildFile)
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

   return conf ~= nil
end

---@return table?
local function getAvailableConfigurations()
   if not reloadConfigurationFile() then
      return nil
   end

   local configurations = {}

   for name, _ in pairs(conf) do
      table.insert(configurations, name)
   end

   return configurations
end


---@param command string
---@return (fun(): string)?
function M.build(command)
   if command == generateCommand then
      return commands[command]
   end

   if not reloadConfigurationFile() then
      return nil
   end

   for name, code in pairs(conf) do
      commands[name] = function () return code end
   end

   local fun = commands[command]

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

   if FM.is_file_exists(buildFile) then
      local configurations = getAvailableConfigurations()

      if configurations then
         return configurations
      end
   end

   return { generateCommand }
end


return M
