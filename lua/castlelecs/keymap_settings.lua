local l = "<leader>"
-- TODO: rename to castlelecs/utils
local k = require('utils').keymap

-- MARK: Navigation
k("n", l .. "pv", ":wincmd v | :e . | :vertical resize 30<CR>")
k("n", l .. "nh", ":noh<CR>")
k("n", "<C-h>", ":tabprev<CR>")
k("n", "<C-l>", ":tabnext<CR>")
k("n", "tn", ":tabnew<CR>")
k("n", "tc", ":tabclose<CR>")

-- MARK: Save and Quit
k("n", l .. "s", ":w<CR>")
k("n", l .. "S", ":wall<CR>")
k("n", l .. "wq", ":wq<CR>")
k("n", l .. "q", ":q<CR>")

-- MARK: Clipboard
k("v", "y", '"+y')

-- MARK: Search
k("n", l .. "F", ":Ag<CR>")
