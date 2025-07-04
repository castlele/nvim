---@class NotesModule
---@field private notesPath string
---@field private lastNotePath string?
local M = {}

function M.openLastNote()
   vim.cmd.split()
   vim.cmd.lcd(M.notesPath)

   if M.lastNotePath then
      vim.cmd.e(M.lastNotePath)
   end

   vim.api.nvim_create_autocmd({ "BufEnter" }, {
      callback = function()
         vim.schedule(function()
            local fileInfo = vim.fn.execute("file")
            local s, e = string.find(fileInfo, '"[^"]*"')

            if s then
               local path = string.sub(fileInfo, s + 1, e - 1)

               if path == "[No Name]" then
                  return
               end

               M.lastNotePath = path
            end
         end)
      end,
      buffer = vim.api.nvim_get_current_buf(),
   })
end

---@class NotesModuleConfig
---@field notesPath string?
---@field keymaps table
---@param config NotesModuleConfig
function M.setup(config)
   if not config.notesPath then
      return
   end

   M.notesPath = config.notesPath

   if config.keymaps then
      require("utils").setKeymaps(config.keymaps)
   end
end

return M
