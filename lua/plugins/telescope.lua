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

require('telescope').load_extension('fzf')

local t = ":Telescope "
local l = "<leader>"
local k = require("utils").keymap

k("n", l .. "O", t .. "find_files<CR>")
k("n", l .. "C", t .. "colorscheme<CR>")
vim.keymap.set(
   "n",
   l .. "F",
   function()
      require("telescope.builtin").find_files({
         cwd = require("lazy.core.config").options.root
      })
   end
)
