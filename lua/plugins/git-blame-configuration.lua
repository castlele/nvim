require('gitblame').setup {
    enabled = false,
}

local k = require("utils").keymap

k("n", "<C-A>", ":GitBlameToggle<CR>")
