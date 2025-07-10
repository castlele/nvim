local function findFilesOverProject()
   local ignore_files = {
      "%.git/",
      "build/",
      "bin/",
   }

   require("telescope.builtin").find_files {
      hidden = true,
      no_ignore = false,
      file_ignore_patterns = ignore_files,
   }
end

local function searchOverCurrentFile()
   require("telescope.builtin").current_buffer_fuzzy_find {
      skip_empty_lines = true,
   }
end

local function searchFileComponents()
   require("telescope.builtin").treesitter {
      symbols = {
         "var",
         "type",
         "function",
         "macro",
      },
   }
end

---@param kbasePath string
local function searchOverKBase(kbasePath)
   require("telescope.builtin").find_files {
      cwd = kbasePath,
      hidden = true,
      no_ignore = true,
      search_file = "*.md",
   }
end

local function live_grep(...)
   require("telescope").extensions.live_grep_args.live_grep_args(...)
end

return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      {
         "nvim-telescope/telescope-live-grep-args.nvim",
         version = "^1.0.0",
      },
      {
         "nvim-telescope/telescope-fzf-native.nvim",
         build = "make",
      },
   },
   config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup {
         defaults = {
            sorting_strategy = "ascending",
            layout_config = {
               horizontal = {
                  prompt_position = "top",
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
                  ["<C-w>"] = actions.send_selected_to_qflist
                     + actions.open_qflist,
               },
            },
         },
         extensions = {
            fzf = {
               -- false will only do exact matching
               fuzzy = true,
               -- override the generic sorter
               override_generic_sorter = true,
               -- override the file sorter
               override_file_sorter = true,
               -- or "ignore_case" or "respect_case"
               -- the default case_mode is "smart_case"
               case_mode = "smart_case",
            },
         },
      }

      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")

      require("utils").setKeymaps {
         n = {
            ["<space>fc"] = searchFileComponents,
            ["<leader>O"] = findFilesOverProject,
            ["<leader>F"] = live_grep,
            ["<leader>f"] = searchOverCurrentFile,
            ["<leader>fkb"] = function()
               searchOverKBase(require("local").kbasePath)
            end,
         },
      }
   end,
}
