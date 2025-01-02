require("cluautils.tests.base_test_case")
require("castlelecs.case_converter")
local strutils = require("cluautils.string_utils")

ToSnakeConvertTest = CTestCase

function ToSnakeConvertTest:test_convert_empty_string()
    local str = ""

    local result = ConvertToSnake(str)

    return strutils.isEmpty(result)
end

function ToSnakeConvertTest:test_convert_one_word()
    local str = "hello"

    local result = ConvertToSnake(str)

    return result == str
end

function ToSnakeConvertTest:test_convert_snake_to_snake()
    local str = "hello_world"

    local result = ConvertToSnake(str)

    return result == str
end

function ToSnakeConvertTest:test_convert_camel_to_snake()
    local str = "helloWorldMan"

    local result = ConvertToSnake(str)

    return result == "hello_world_man"
end

function ToSnakeConvertTest:test_convert_camel_to_snake_with_first_capital()
    local str = "HelloWorldMan"

    local result = ConvertToSnake(str)

    return result == "hello_world_man"
end

ToSnakeConvertTest:run_tests()
