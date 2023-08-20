require("cluautils.tests.base_test_case")
require("cluautils.string_utils")
require("lua.castlelecs.case_converter")

ToSnakeConvertTest = CTestCase

function ToSnakeConvertTest:test_convert_empty_string()
    local str = ""

    local result = ConvertToSnake(str)

    return result:is_empty()
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

function ToSnakeConvertTest:Test_convert_camel_to_snake_with_first_capital()
    local str = "HelloWorldMan"

    local result = ConvertToSnake(str)

    return result == "hello_world_man"
end

ToSnakeConvertTest:run_tests()
