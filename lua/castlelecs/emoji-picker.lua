---@class EmojiPickerModule
local M = {}

function M.searchBuildWithTelescope()
   local finders = require("telescope.finders")
   local pickers = require("telescope.pickers")
   local previewers = require("telescope.previewers")
   local config = require("telescope.config").values
   local actionState = require("telescope.actions.state")
   local actions = require("telescope.actions")
   local opts = {
      cwd = vim.uv.cwd(),
   }

   local emojis = require("castlelecs.res.emojis")

   local finder = finders.new_table {
      results = emojis,
      entry_maker = function(entry)
         return {
            value = entry,
            display = entry.emoji .. " " .. entry.shortname,
            ordinal = entry.shortname,
         }
      end,
      cwd = opts.cwd,
   }

   pickers
      .new(opts, {
         debounce = 0,
         prompt_title = "List of emojis",
         finder = finder,
         previewer = previewers.new_buffer_previewer {
            define_preview = function(self, entry)
               vim.api.nvim_buf_set_lines(
                  self.state.bufnr,
                  0,
                  -1,
                  false,
                  vim.split(vim.inspect(entry), "\n")
               )
            end,
         },
         sorter = config.generic_sorter(opts),
         attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
               actions.close(prompt_bufnr)

               local selection = actionState.get_selected_entry()
               local index = selection.index
               local emoji = emojis[index].emoji

               vim.fn.setreg('"', emoji)
            end)
            return true
         end,
      })
      :find()
end

---@class EmojiPickerModuleConfig
---@field keymaps table
function M.setup(config)
   local utils = require("utils")

   if not config.keymaps then
      return
   end

   utils.setKeymaps(config.keymaps)
end

return M
