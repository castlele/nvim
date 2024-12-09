local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")

require('telescope').setup {
   defaults = {
      layout_config = {
         horizontal = {
            prompt_position = "bottom",
            width = { padding = 0 },
            height = { padding = 0 },
            preview_width = 0.7,
         },
      },
      path_display = {
         "filename_first",
      },
      mappings = {
         i = {
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-y>"] = layout.toggle_preview,
         },
      },
   },
   extensions = {
      fzf = {
         fuzzy = true,                    -- false will only do exact matching
         override_generic_sorter = true,  -- override the generic sorter
         override_file_sorter = true,     -- override the file sorter
         case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                          -- the default case_mode is "smart_case"
      },
   }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("live_grep_args")

local function find_files()
   local ignore_files = {
      "%.git/",
      "build/",
      "bin/",
   }

   require("telescope.builtin").find_files {
      hidden = true,
      no_ignore = true,
      file_ignore_patterns = ignore_files,
   }
end

local t = ":Telescope "
local l = "<leader>"
local utils = require("utils")

utils.keymap_func("n", l .. "O", find_files)
utils.keymap_func("n", l .. "F", require("telescope").extensions.live_grep_args.live_grep_args)
utils.keymap("n", l .. "C", t .. "colorscheme<CR>")
