vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter.git" }

local ts = require("nvim-treesitter")

ts.setup()

local languages = {
   "go",
   "c",
   "cpp",
   "lua",
   "vimdoc",
   "vim",
   "norg",
   "kotlin",
   "java",
   "swift",
   "objc",
}

ts.update(languages)

vim.api.nvim_create_autocmd("FileType", {
   pattern = languages,
   callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
   end,
})
