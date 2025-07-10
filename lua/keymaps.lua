local customKeymaps = {
   n = {
      ["<leader>nh"] = vim.cmd.noh,
      ["th"] = vim.cmd.tabprev,
      ["tl"] = vim.cmd.tabnext,
      ["tn"] = vim.cmd.tabnew,
      ["_"] = function() vim.cmd("Ex") end,
   },
}

local utils = require("utils")

utils.setKeymaps(customKeymaps)
utils.keymap("n", "y", '"+y')
utils.keymap("v", "y", '"+y')
