---@class GradleModule
local M = {}

---@param args table<string>
---@return table<string, string>
local function parseCommandArgsToTable(args)
   local result = {}

   for _, arg in ipairs(args) do
      local keyValue = vim.split(arg, "=")

      if #keyValue ~= 2 then
         error(
            string.format(
               "Invalid argument %s. Args have the following format: key=value",
               arg
            )
         )
      end

      result[keyValue[1]] = keyValue[2]
   end

   return result
end

function M.runGradleCommand(command, args)
   -- TODO: Implement all commands
   if command == "create-module" then
      if not args.name or #args.name == 0 then
         vim.notify(
            "You have to specify name= argument for this command",
            vim.log.levels.WARN
         )
         return
      end

      vim.cmd("!mkdir " .. args.name)
      vim.cmd(string.format("!touch %s/build.gradle.kts", args.name))
      vim.cmd(
         string.format(
            "!echo 'include(\":%s\")' >> settings.gradle.kts",
            args.name
         )
      )

      if not args.type then
         return
      end

      local mainPath = string.format("%s/src/main/%s/", args.name, args.type)
      local testPath = string.format("%s/src/test/%s/", args.name, args.type)

      vim.cmd("!mkdir -p " .. mainPath)
      vim.cmd("!mkdir -p " .. testPath)

      if args.group and #args.group > 0 then
         local pathComponents = vim.split(args.group, ".", { plain = true })
         local path = table.concat(pathComponents, "/")

         vim.cmd("!mkdir -p " .. mainPath .. path)
         vim.cmd("!mkdir -p " .. testPath .. path)
      end
   end
end

---@class GradleModuleConfig
---@param opts GradleModuleConfig
function M.setup(opts)
   -- TODO: Implement. It should get and parse all current gradle tasks to use in GradleRun command
   -- vim.api.nvim_create_user_command("GradleSync", function(args) end, {})
   -- vim.api.nvim_create_user_command("GradleRun", function(args) end, {})

   vim.api.nvim_create_user_command("Gradle", function(args)
      local fargs = args.fargs
      local command = args.fargs[1]
      local commandArgs = vim.list_slice(fargs, 2, #fargs)

      M.runGradleCommand(command, parseCommandArgsToTable(commandArgs))
   end, {
      desc = "Gradle project manipulation commands",
      complete = function(filter, command)
         local commands = vim.split(command, " ")

         if #commands >= 1 then
            table.remove(commands, 1)
         end

         local availableCompletions = {}

         if #commands == 1 then
            availableCompletions = {
               "run",
               "create-module",
            }
         else
            availableCompletions = {}

            if commands[1] == "create-module" then
               -- TODO: filter to be unique
               availableCompletions = {
                  "name=",
                  "type=java",
                  "type=kotlin",
                  "group=",
               }
            end
         end

         return require("utils").completion(filter, availableCompletions)
      end,
      nargs = "*",
   })
end

return M
