local function swap_lines(from, to, lines)
   vim.api.nvim_buf_set_lines(0, from - 1, to, false, lines)
end

--- If some range was selected and there are import statements, those statements is sorted in alphabetical order.
function SSImports()
   local lines, from, to = require("utils").getSelectedLines()

   if #lines == 0 then
      vim.notify("No lines selected for extraction", vim.log.levels.WARN)
      return
   end

   table.sort(lines)

   swap_lines(from, to, lines)
end

vim.api.nvim_create_user_command("SSImports", SSImports, { desc = "sorting swift imports" })

local post = "<CR>"
local l = "<leader>"
local k = require('utils').keymap

k("v", l .. "ssi", ":<C-U>SSImports" .. post)
