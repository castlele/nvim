vim.pack.add {
   "https://github.com/iamcco/markdown-preview.nvim.git",
}

vim.fn["mkdp#util#install"]()
vim.g.mkdp_open_to_the_world = 1

local l = "<leader>"
local prefix = ":MarkdownPreview"
local k = require("utils").keymap

k("n", l .. "mp", prefix .. "<CR>")
k("n", l .. "mps", prefix .. "Stop<CR>")
