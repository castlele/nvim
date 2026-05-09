vim.pack.add {
   "https://github.com/Wansmer/treesj.git",
   "https://github.com/nvim-treesitter/nvim-treesitter.git",
}

require("nvim-treesitter").setup()
require("treesj").setup()
