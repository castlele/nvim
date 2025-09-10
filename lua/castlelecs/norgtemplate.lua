local FM = require("cluautils.file_manager")

---@class TemplateModule
---@field config WeekConfiguration?
---@field header string?
---@field sectionFooter string?
local M = {}

---@param str string
---@param times integer
---@return string
local function strRepeating(str, times)
   local result = ""

   for _ = 1, times do
      result = result .. str
   end

   return result
end

---@return string
local function getFileContent()
   if not M.config then
      return ""
   end

   ---@type string
   local result = ""

   if M.header then
      result = tostring(M.header)
   end

   local days = {
      "SUN", "SAT", "FRI", "THU", "WED", "TUE", "MON",
   }

   local function addLevel(level, text)
      local endl = ""

      if #result ~= 0 then
         endl = "\n"
      end

      result = result .. string.format("%s%s %s", endl, strRepeating("~", level), text)
   end

   local function addTasks(level, tasks)
      local l = level + 1

      for taskName, task in pairs(tasks) do
         if type(task) == "table" then
            addLevel(l, "( ) " .. taskName)
            addTasks(l, task)
         else
            addLevel(l, "( ) " .. task)
         end
      end
   end

   for _, day in ipairs(days) do
      local tasks = M.config[day]
      local level = 1

      addLevel(level, "( ) " .. day)
      addTasks(level, tasks)

      if M.sectionFooter then
         result = result .. string.format("\n\n%s", tostring(M.sectionFooter))
      end

      result = result .. "\n"
   end

   return result
end

local function createFile(date)
   local fileName = date .. ".norg"

   local path = vim.fn.expand("%:p:h") .. "/"

   local filePath = path .. fileName

   if FM.is_file_exists(filePath) then
      vim.notify(
         "File at filePath already exist: " .. filePath,
         vim.log.levels.ERROR
      )
      return
   end

   FM.write_to_file(filePath, IOMODE.WRITE, function()
      return getFileContent()
   end)
end

local function completion(date)
   local day = 24 * 60 * 60
   local currentTime = os.time()
   local pattern = "%d.%m"

   local today = os.date(pattern, currentTime)
   local tomorrow = os.date(pattern, currentTime + day)
   local afterTomorrow = os.date(pattern, currentTime + day * 2)
   local dates = { today, tomorrow, afterTomorrow }

   if #date ~= 0 then
      table.insert(dates, 1, date)
   end

   return dates
end

local function registerVimCommand()
   local opts = {
      desc = "Norg template generation",
      complete = completion,
      nargs = 1,
   }

   vim.api.nvim_create_user_command("NorgTemplate", function(args)
      createFile(args.args)
   end, opts)
end

---@class WeekConfiguration
---@field week table
---@field sectionFooter string?
---@field header string?
---@param opts WeekConfiguration
function M.setup(opts)
   M.config = opts.week
   M.sectionFooter = opts.sectionFooter
   M.header = opts.header

   registerVimCommand()
end

return M
