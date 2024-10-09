require("cluautils.tests.base_test_case")

local plugin = require("castlelecs.init_declaration_to_usage")

CallFromInitTest = CTestCase

---@type RulesSet
local commonRulesSet = plugin.RulesSet:new(
   {"var", "val"},
   ":",
   " = ",
   ",",
   true
)
ConvertToCallFromInit = plugin.ConvertToCallFromInit

function CallFromInitTest:test_convert_from_empty_string()
   local str = ""

   local result = ConvertToCallFromInit(str, commonRulesSet)

   return result == str
end

function CallFromInitTest:test_convert_from_empty_lines_string()
   local str = [[



   ]]

   local result = ConvertToCallFromInit(str, commonRulesSet)

   return result == ""
end

function CallFromInitTest:test_convert_one_correct_line()
   local str = "var stringField: String"
   local expectedResult = "stringField = String,"

   local result = ConvertToCallFromInit(str, commonRulesSet)

   return result == expectedResult
end

function CallFromInitTest:test_convert_multiple_correct_lines()
   local str = [[
   var boolField: Boolean,
   val stringField: String
   ]]
   local expectedResult = [[
   boolField = Boolean,
   stringField = String,]]

   local result = ConvertToCallFromInit(str, commonRulesSet)

   return result == expectedResult
end

CallFromInitTest:run_tests()
