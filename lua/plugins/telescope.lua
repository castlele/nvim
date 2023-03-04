-- TODO: rename script to telescope_setup.lua

local t = ":Telescope "
local l = "<leader>"
-- TODO: rename to castlelecs.utils
local k = require("utils").keymap

k("n", l .. ";", t .. "buffers<CR>")
k("n", l .. "O", t .. "find_files<CR>")
k("n", l .. "C", t .. "colorscheme<CR>")
