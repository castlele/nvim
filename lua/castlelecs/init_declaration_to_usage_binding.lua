require("castlelecs.init_declaration_to_usage")

local commandName = "CallFromInit"

vim.api.nvim_create_user_command(
   commandName,
   CallFromInit,
   { desc = "Toggling from Init to calling usage", nargs = 0 }
)

local post = "<CR>"
local k = require('utils').keymap

k("v", "cfi", ":<C-U>" .. commandName .. post)
