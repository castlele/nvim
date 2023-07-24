local t = ":Telescope "
local l = "<leader>"
local k = require("utils").keymap

k("n", l .. ";", t .. "buffers<CR>")
k("n", l .. "O", t .. "find_files<CR>")
k("n", l .. "C", t .. "colorscheme<CR>")
