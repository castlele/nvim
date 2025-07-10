local customKeymaps = {
   n = {
      ["<leader>nh"] = vim.cmd.noh,
      ["th"] = vim.cmd.tabprev,
      ["tl"] = vim.cmd.tabnext,
      ["tn"] = vim.cmd.tabnew,
   },
}
require("utils").setKeymaps(customKeymaps)
require("utils").keymap("n", "y", '"+y')
require("utils").keymap("v", "y", '"+y')
