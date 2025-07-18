return {
   "akinsho/toggleterm.nvim",
   version = "*",
   config = function()
      local utils = require("utils")

      -- TODO: Create a command to push all my current changes with message

      require("toggleterm").setup()

      local Terminal = require("toggleterm.terminal").Terminal
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

      local l = "<leader>"
      utils.keymap_func("n", l .. "tf", show_floating_terminal)
      utils.keymap_func("n", l .. "tb", show_bottom_terminal)
      utils.keymap_func("n", l .. "tt", show_tab_terminal)
   end,
}
