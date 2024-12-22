local utils = require('utils')
local build = require("castlelecs.build")

require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
local floating_terminal = Terminal:new {
   direction = "float",
}
local bottom_terminal = Terminal:new {
   direction = "horizontal",
}
local tab_terminal = Terminal:new {
   direction = "tab",
}

local function show_bottom_terminal()
   bottom_terminal:toggle()
end

local function show_floating_terminal()
   floating_terminal:toggle()
end

local function show_tab_terminal()
   tab_terminal:toggle()
end

---@param command string
---@param name string?
---@param layout "float"|"horizontal"|"tab"|"vertical"
local function newTerminal(command, name, layout)
   Terminal:new {
      direction = layout,
      cmd = command,
      display_name = name,
      hidden = false,
      close_on_exit = false,
   }:toggle()
end

local function buildCommandBinding(args)
   local fun = build.build(args.args)

   if not fun then
      return
   end

   local terminalCommand = fun()

   if terminalCommand then
      -- TODO: Add configuration of layout from nvim command
      newTerminal(terminalCommand, args.args, "horizontal")
   end
end

local l = "<leader>"
utils.keymap_func("n", l .. "tf", show_floating_terminal)
utils.keymap_func("n", l .. "tb", show_bottom_terminal)
utils.keymap_func("n", l .. "tt", show_tab_terminal)
vim.api.nvim_create_user_command(
   "Build",
   buildCommandBinding,
   {
      desc = "Build",
      complete = build.completion,
      nargs = 1,
   }
)
