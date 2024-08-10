require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- Install fzf first
require('telescope').load_extension('fzf')
-- Install ripgrep first
require("telescope").load_extension("live_grep_args")

local t = ":Telescope "
local l = "<leader>"
local utils = require("utils")

utils.keymap('n', l .. "O", '<cmd>lua require("telescope.builtin").find_files({hidden = true})<CR>')
utils.keymap_func('n', '<leader>F', require("telescope").extensions.live_grep_args.live_grep_args)
utils.keymap("n", l .. "C", t .. "colorscheme<CR>")
