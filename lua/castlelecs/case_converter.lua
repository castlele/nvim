local strutils = require("cluautils.string_utils")

local ARGS = 'args'
local SNAKE = 'Snake'
local CAMEL = 'Camel'

---@param str string
---@return string
function ConvertToSnake(str)
    local result = ""
    local prev_index = 1

    for i = 1, #str do
        local char = str:sub(i, i)
        local last_part = ""

        if prev_index - i == 0 then
            last_part = char
        else
            last_part = "_" .. char
        end

        if char:match("%u") then
            result = result .. str:sub(prev_index, i - 1) .. last_part
            prev_index = i + 1
        end
    end

    if strutils.isEmpty(result) then
        return str:lower()
    end

    result = result .. str:sub(prev_index, #str)
    return result:lower()
end

---@param str string
---@return string
function ConvertToCamel(str)
    local result = ""
    local prev_index = 1

    for i = 1, #str do
        local char = str:sub(i, i)

        if char == "_" then
            local camel = str:sub(prev_index, prev_index):upper()
            local body = str:sub(prev_index + 1, i - 1)

            if strutils.isEmpty(result) then
                camel = camel:lower()
            end

            result = result .. camel .. body

            prev_index = i + 1
        end
    end

    if strutils.isEmpty(result) then
        return str
    end

    local camel = str:sub(prev_index, prev_index):upper()
    local body = str:sub(prev_index + 1, #str)

    return (result .. camel .. body)
end

function ToggleCase(cmd)
    if cmd == nil then
        return
    end

    local str = vim.fn.expand("<cword>")
    local result = ""

    if cmd[ARGS] == SNAKE then
        result = ConvertToSnake(str)
    elseif cmd[ARGS] == CAMEL then
        result = ConvertToCamel(str)
    end

    vim.cmd("normal! diwi" ..  result)
end

function Completion()
    return { SNAKE, CAMEL }
end
