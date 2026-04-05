vim.pack.add { "https://github.com/ntpeters/vim-better-whitespace.git" }
local k = require("utils").keymap

-- TODO: Move outside of configuration + think about keymap itself, is it needed?
k("n", "<leader>cc", ":StripWhitespace<CR>")
