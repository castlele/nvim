local k = require('utils').keymap

-- TODO: Move outside of configuration + think about keymap itself, is it needed?
k("n", "<leader>cc", ":StripWhitespace<CR>")
