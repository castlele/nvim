local post = "<CR>"
local l = "<leader>"
local k = require('utils').keymap

-- MARK: Navigation
k("n", l .. "pv", ":wincmd v | :e . | :vertical resize 30" .. post)
k("n", l .. "nh", ":noh" .. post)
k("n", "<C-h>", ":tabprev" .. post)
k("n", "<C-l>", ":tabnext" .. post)
k("n", "tn", ":tabnew" .. post)
k("n", "tc", ":tabclose" .. post)

-- Close bottom windown
k("n", l .. "jq", ":wincmd j | :q" .. post)

-- MARK: Save and Quit
k("n", l .. "w", ":w" .. post)
k("n", l .. "W", ":wall" .. post)
k("n", l .. "wq", ":wq" .. post)
k("n", l .. "q", ":q" .. post)

-- MARK: Clipboard
k("v", "y", '"+y')

-- MARK: Search
k("n", l .. "F", ":Ag" .. post)
