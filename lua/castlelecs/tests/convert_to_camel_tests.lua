require("cluautils.tests.base_test_case")
require("cluautils.tests.base_test_case")
require("lua.castlelecs.case_converter")

ToCamelConvertTest = CTestCase

function ToCamelConvertTest:test_convert_empty_string()
    local str = ""

    local result = ConvertToCamel(str)

    return result:is_empty()
end

function ToCamelConvertTest:test_convert_one_word()
    local str = "hello"

    local result = ConvertToCamel(str)

    return result == str
end

function ToCamelConvertTest:test_convert_camel_to_camel()
    local str = "helloWorld"

    local result = ConvertToCamel(str)

    return result == str
end

function ToCamelConvertTest:test_convert_snake_to_camel()
    local str = "hello_world_man"

    local result = ConvertToCamel(str)

    return result == "helloWorldMan"
end

ToCamelConvertTest:run_tests()
