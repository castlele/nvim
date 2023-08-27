require("cluautils.string_utils")

---@param str string
---@return number?
local function get_indent(str)
    local s, e = str:find("^%s+")

    if s == nil then
        return nil
    end

    return e
end

---@param lines table
---@return number
local function get_min_indent(lines)
    local min_indent = 1000000

    for _, line in pairs(lines) do
        local indent_index = get_indent(line)

        if indent_index == nil then
            return 0
        end

        if min_indent > indent_index then
            min_indent = indent_index
        end
    end

    return min_indent
end

---@param num number
---@return string
local function create_indent(num)
    local indent = ""

    for _ = 1, num, 1 do
        indent = indent .. " "
    end

    return indent
end

---@param prefix string
---@param author string
---@param params table?
---@return string
local function create_header(prefix, author, params)
    local header = {prefix .. "Author: " .. author}

    for key, value in pairs(params or {}) do
        local line = prefix .. tostring(key):upper() .. ": " .. value

        table.insert(header, line)
    end

    return table.concat(header, "\n")
end

---@param comment_prefix string
---@param input_string string
---@param author string
---@param params table?
---@return string
function Comment(comment_prefix, input_string, author, params)
    local commented_lines = input_string:split("\n")
    local min_indent_index = get_min_indent(commented_lines)
    local min_indent = create_indent(min_indent_index)

    for index, line in ipairs(commented_lines) do
        if not line:is_empty() and line:trim():find(comment_prefix, nil, true) ~= 1 then
            local current_indent_index = get_indent(line) or min_indent_index
            local current_indent = create_indent(current_indent_index - min_indent_index)

            commented_lines[index] = min_indent .. comment_prefix .. " " ..current_indent .. line:triml()
        end
    end

    local header = create_header(min_indent .. comment_prefix .. " ", author, params)

    if input_string:is_empty() then
        return header
    end

    return header .. "\n" .. table.concat(commented_lines, "\n")
end
