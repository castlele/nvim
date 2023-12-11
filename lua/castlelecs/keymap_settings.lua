local k = require('utils').keymap
local post = "<CR>"
local l = "<leader>"

---@MARK - Navigation
k("n", l .. "nh", ":noh" .. post)
k("n", "th", ":tabprev" .. post)
k("n", "tl", ":tabnext" .. post)
k("n", "tn", ":tabnew" .. post)
k("n", "<C-s>", ":Neotree toggle" .. post)

---@MARK - Clipboard
k("v", "y", '"+y')
k("n", "y", '"+y')
