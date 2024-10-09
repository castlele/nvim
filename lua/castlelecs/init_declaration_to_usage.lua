require("cluautils.string_utils")

---@class RulesSet
---@field declKeywords table<string>
---@field declSeparator string
---@field callSeparator string
---@field lineSeparator string
---@field isLastLineSeparated boolean
local RulesSet = {}
RulesSet.__index = RulesSet

---@param declKeywords table<string>
---@param declSeparator string
---@param callSeparator string
---@param lineSeparator string
---@param isLastLineSeparated boolean
function RulesSet:new(
   declKeywords,
   declSeparator,
   callSeparator,
   lineSeparator,
   isLastLineSeparated

)
   ---@type RulesSet
   local this = {
      declKeywords = declKeywords,
      declSeparator = declSeparator,
      callSeparator = callSeparator,
      lineSeparator = lineSeparator,
      isLastLineSeparated = isLastLineSeparated,
   }

   setmetatable(this, self)

   self.__index = self

   return this
end

---@param str string
---@param rules RulesSet
---@return string
function ConvertToCallFromInit(str, rules)
   local trimmedStr = str:trim()

   if trimmedStr:is_empty() then
      return trimmedStr
   end

   local result = ""
   local lines = str:split("\n")

   for index, line in ipairs(lines) do
      if not line:trim():is_empty() then

         for _, keyword in ipairs(rules.declKeywords) do
            if not keyword:is_empty() then
               local noKeyword, _ = string.gsub(line, keyword .. " ", "", 1)

               if noKeyword ~= line then
                  line = noKeyword
                  break
               end
            end
         end

         line, _ = string.gsub(line, "%s*:%s*", rules.callSeparator)

         if index == #lines and not rules.isLastLineSeparated then
            break
         end

         if not result:is_empty() then
            result = result .. "\n"
         end

         result = result .. line

         if string.sub(line, string.len(line)) ~= rules.lineSeparator then
            result = result .. rules.lineSeparator
         end
      end
   end

   return result
end

---@retur string[]
local function getSelectedLines(from, to)
    if to < from then
        from, to = to, from
    end

    local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, false)

    return lines
end

---@return string
local function getSelectedLinesString()
   local from = vim.fn.getpos("'<")[2]
   local to = vim.fn.getpos("'>")[2]

   if from == nil or to == nil then
      return ""
   end

   local lines = getSelectedLines(from, to)

   return table.concat(lines, "\n")
end

---@pram lines string
local function swapLines(lines)
   local from = vim.fn.getpos("'<")[2]
   local to = vim.fn.getpos("'>")[2]

   if from == nil or to == nil then
      return
   end

   vim.api.nvim_buf_set_lines(0, from - 1, to, false, lines:split("\n"))
end

function CallFromInit()
   ---@type RulesSet
   local rules
   local filetype = vim.bo.filetype
   local selectedLines = getSelectedLinesString()

   if filetype == "kotlin" then
      rules = RulesSet:new({"var", "val"}, ":", " = ", ",", true)
   else
      return
   end

   local result = ConvertToCallFromInit(selectedLines, rules)

   swapLines(result)
end

return {
   RulesSet = RulesSet,
   CallFromInit = CallFromInit,
   ConvertToCallFromInit = ConvertToCallFromInit,
}
