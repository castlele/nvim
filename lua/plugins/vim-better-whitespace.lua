return {
   "ntpeters/vim-better-whitespace",
   config = function()
      local k = require('utils').keymap

      -- TODO: Move outside of configuration + think about keymap itself, is it needed?
      k("n", "<leader>cc", ":StripWhitespace<CR>")
   end,
}
