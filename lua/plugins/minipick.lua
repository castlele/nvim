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
            -- TODO: Make names for keymaps more obvious
            ["<leader>O"] = picker.builtin.files,
            ["<leader>IO"] = function ()
               picker.builtin.cli(
                  {
                     command = {
                        "rg", "--files", "--color=never", "-uu",
                     }
                  },
                  {
                     source = {
                        name = "Files with gitignore",
                     },
                  }
               )
            end,
            ["<leader>F"] = picker.builtin.grep_live,
            ["<leader>H"] = picker.builtin.help,
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
