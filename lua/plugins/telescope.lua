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
   end,
}
