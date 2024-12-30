require("cluautils.table_utils")

local function get_selected_lines(from, to)
    if to < from then
        from, to = to, from
    end

    local lines = vim.api.nvim_buf_get_lines(0, from - 1, to, false)

    return lines
end

local function swap_lines(from, to, lines)
   vim.api.nvim_buf_set_lines(0, from - 1, to, false, lines)
end

--- If some range was selected and there are import statements, those statements is sorted in alphabetical order.
--- File type should be equal to swift.
function SSImports()
   local from = vim.fn.getpos("'<")[2]
   local to = vim.fn.getpos("'>")[2]

   if from == nil or to == nil then
      return
   end

   local lines = get_selected_lines(from, to)

   table.sort(lines)

   swap_lines(from, to, lines)
end

vim.api.nvim_create_user_command("SSImports", SSImports, { desc = "sorting swift imports" })

local post = "<CR>"
local l = "<leader>"
local k = require('utils').keymap

k("v", l .. "ssi", ":<C-U>SSImports" .. post)
