local post = "<CR>"
local l = "<leader>"
local k = require('utils').keymap

---@MARK - COQ Unbind

vim.g.coq_settings = {
    ["auto_start"] = "shut-up",
    ["keymap.recommended"] = true,
}

---@MARK - Navigation
k("n", l .. "nh", ":noh" .. post)
k("n", "th", ":tabprev" .. post)
k("n", "tl", ":tabnext" .. post)
k("n", "tn", ":tabnew" .. post)
k("n", l .. "<C-W>", ":wall" .. post)
k("n", l .. "wq", ":wq" .. post)
k("n", l .. "<C-Q>", ":qall" .. post)
k("n", "<C-s>", ":Neotree toggle" .. post)
k("n", l .. "qfo", ":copen" .. post)
k("n", l .. "qfc", ":cclose" .. post)

---@MARK - Clipboard
k("v", "y", '"+y')
k("n", "y", '"+y')

---@MARK - Search
k("n", l .. "F", ":Ag" .. post)
