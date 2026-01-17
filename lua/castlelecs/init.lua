require("castlelecs.case_converter_binding")
require("castlelecs.imports_sorting")
require("castlelecs.norgtemplate").setup(require("weekOpts"))
require("castlelecs.extract").setup()
require("castlelecs.sync").setup {
   items = {
      {
         path = "$HOME/notes/",
         auto_cmd = "BufWritePost",
         sync_cmd = function()
            print("hello")
         end,
      },
   },
}

local locals = require("local")
local picker = require("castlelecs.emoji-picker")
picker.setup {
   keymaps = {
      n = {
         ["<leader>E"] = picker.searchEmojiWithMinipick,
      },
   },
}

require("castlelecs.obsidian").setup {
   vaults = {
      {
         path = locals.kbasePath,
         res = "res",
         templates = "templates",
      },
   },
}

local notesModule = require("castlelecs.notes")
notesModule.setup {
   notesPath = locals.notesPath,
   keymaps = {
      n = {
         ["<leader>n"] = notesModule.openLastNote,
      },
   },
}

require("castlelecs.gradle").setup {}
