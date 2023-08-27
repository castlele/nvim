require("castlelecs.author_comments")
require("cluautils.string_utils")

---@class param
---@field default_author_name string?
---@field comment_sign_for_unknown_files string
---@field user_arguments table
---@field comment_signs table
local author_vim = {
    default_author_name=nil,
    comment_sign_for_unknown_files="//",
    user_arguments={},
    comment_signs={
        swift="//",
        python="#",
        sh="#",
        objc="//",
        objcpp="//",
        c="//",
        cpp="//",
        lua="--",
    }
}

---@param params param
local function setup(params)
    if params == nil then
        return
    end

    for key, value in pairs(params) do
        if type(value) == "table" then
            table.foreach(value, function (_, inner_value)
                table.insert(author_vim[key], inner_value)
            end)
        else
            author_vim[key] = value
        end
    end
end

local function completion()
    local default = {"Author=", "TODO=", "FIXME="}

    for _, user_param in pairs(author_vim.user_arguments) do
        table.insert(default, user_param)
    end

    return default
end

---@param args table
---@return string|nil
---@return table|nil
local function parse_arguments(args)
    local author=author_vim.default_author_name
    local params = {
        todo=nil,
        fixme=nil,
    }

    for _, arg in pairs(args) do
        local key_value = string.split(arg, "=")
        local lower_key = string.lower(key_value[1])

        if lower_key == "author" then
            author = key_value[2]

        elseif lower_key == "todo" then
            params.todo = key_value[2] or ""

        elseif lower_key == "fixme" then
            params.fixme = key_value[2] or ""

        else
            params[string.upper(key_value[1])] = key_value[2]
        end
    end

    if author == nil then
        vim.notify("To use coment you should add Author argument or set it in your neovim config", vim.log.levels.WARN)
        return nil
    end

    return author, params
end

---@return string
---@return number
---@return number|nil
local function get_currently_selected_lines()
    local from = vim.fn.getpos("'<")[2]
    local to = vim.fn.getpos("'>")[2]

    if to < from then
        from, to = to, from
    end

    if from == nil or to == nil then
        return "", vim.api.nvim_win_get_cursor(0)[1], nil
    end

    local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, false)

    return table.concat(lines, "\n"), from, to

end

---@param comment string
---@param from number
---@param to number|nil
---@param is_new_line boolean
local function override_selected(comment, from, to, is_new_line)
    if to == nil then
        to = from
    end

    if is_new_line then
        vim.api.nvim_buf_set_lines(0, from - 1, to - 1, false, {""})
    end

    vim.api.nvim_buf_set_lines(0, from - 1, to, false, comment:split("\n"))
end

local function author_vim_wrapper(args)
    local author, parsed_args = parse_arguments(args.fargs)

    if author == nil then
        return
    end

    local filetype = vim.bo.filetype
    local comment_prefix = author_vim.comment_signs[filetype] or author_vim.comment_sign_for_unknown_files
    local selected_lines, from, to = get_currently_selected_lines()

    local comment = Comment(comment_prefix, selected_lines, author, parsed_args)

    override_selected(comment, from, to, selected_lines:is_empty())
end

vim.api.nvim_create_user_command("Comment", author_vim_wrapper, { desc="Comment", complete=completion, nargs="*" })

local k = require("utils").keymap
k("v", "gca", ":<C-U>Comment TODO=<CR>")
k("n", "gca", ":<C-U>Comment TODO=<CR>")

return setup




