local k = require('utils').keymap
local post = "<CR>"
local l = "<leader>"

require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
local floating_terminal = Terminal:new {
   direction = "float",
}
local bottom_terminal = Terminal:new {
   direction = "horizontal",
}

function _G.show_bottom_terminal()
   bottom_terminal:toggle()
end

function _G.show_floating_terminal()
   floating_terminal:toggle()
end

function _G.set_terminal_keymaps()
   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

k("n", l .. "tf", ":lua show_floating_terminal()" .. post)
k("n", l .. "tt", ":lua show_bottom_terminal()" .. post)

