require("oil").setup {
   --- BUG: Set this value to false if there is a need to use netrw
   --- source: https://github.com/stevearc/oil.nvim/issues/163
   default_file_explorer = true,
   view_options = {
      show_hidden = true,
   },
}

vim.keymap.set("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })
