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

      result = string.format(result .. "%s%s %s", endl, strRepeating("~", level), text:gsub("%%","%%%1"))
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

      addLevel(level, day)
      addTasks(level, tasks)

      if M.sectionFooter then
         result = string.format(result .. "\n\n%s", tostring(M.sectionFooter))
      end

      result = result .. "\n"
   end

   return result
end

---@param char string
---@param origin string
---@return integer?
local function lastIndexOf(char, origin)
   ---@type integer?
   local last = nil

   for i = 1, #origin do
      local c = origin:sub(i, i)

      if char == c then
         last = i
      end
   end

   return last
end

local function createFile(date)
   local fileName = date .. ".norg"

   local bufferPath = vim.fn.expand("%")
   local path = bufferPath:sub(1, lastIndexOf("/", bufferPath))

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
   local dates = { date, today, tomorrow, afterTomorrow }

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


M.setup {
   week = {
      MON = {
         "work - 3h",
         "fill stats",
         "prepare next week file",
         "take care of Javie",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      TUE = {
         ["work - 3h"] = {
            "design demo",
         },
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      WED = {
         "work - 3h",
         "clean the floors",
         "clean the office",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      THU = {
         "work - 3h",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      FRI = {
         "psychology session %13:00% - 1h",
         "work - 3h",
         "take care of Javie",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      SAT = {
         "followattr - 1h",
         "comeback - 30m",
         "call to grandmother",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
      SUN = {
         "followattr - 1h",
         "comeback - 30m",
         "clean the floors",
         "clean the office",
         "review goals",
         "review week",
         daily = {
            "do sport",
            "meditate",
            "read book",
         },
      },
   },
   sectionFooter = string.format(
      "%s\n%s",
      "total: ",
      "result: "
   ),
   header = string.format(
      "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
      "@document.meta",
      "stats: [",
      "    resting     : 0",
      "    work        : 0",
      "    uni         : 0",
      "    health      : 0",
      "    social      : 0",
      "    relationship: 0",
      "    projects    : 0",
      "    finances    : 0",
      "]",
      "@end"
   )
}
registerVimCommand()

return M
