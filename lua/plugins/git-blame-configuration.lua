require('gitblame').setup {
    enabled = false,
}

local k = require("utils").keymap

k("n", "<leader>A", ":GitBlameToggle<CR>")
