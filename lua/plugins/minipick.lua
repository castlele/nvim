return {
   "echasnovski/mini.pick",
   version = false,
   config = function()
      local picker = require("mini.pick")

      picker.setup {
         mappings = {
            mark_all = "<C-q>"
         },
      }

      require("utils").setKeymaps {
         n = {
            ["<leader>O"] = picker.builtin.files,
            ["<leader>F"] = picker.builtin.grep_live,
            ["<leader>fkb"] = function ()
               picker.builtin.files(nil, {
                  source = {
                     cwd = require("local").kbasePath
                  }
               })
            end,
         },
      }
   end,
}
