---@class ExtractionModule
local M = {}

---@param filename string
function M.extract(filename)
   local lines, from, to = require("utils").getSelectedLines()

   if #lines == 0 then
      vim.notify("No lines selected for extraction", vim.log.levels.WARN)
      return
   end

   local path = vim.fn.expand("%:p:h") .. "/" .. filename
   local FM = require("cluautils.file_manager")

   if FM.is_file_exists(path) then
      vim.notify(
         "File at file path already exists: " .. path,
         vim.log.levels.ERROR
      )
      return
   end

   FM.write_to_file(path, IOMODE.WRITE, function()
      return table.concat(lines, "\n")
   end)

   vim.api.nvim_buf_set_lines(0, from, to, false, {})
end

function M.setup()
   vim.api.nvim_create_user_command("CodeExtractToFile", function(args)
      M.extract(args.args)
   end, {
         desc = "Extract selected text into file",
         range = true,
         nargs = 1,
   })
end

return M
