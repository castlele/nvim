local locals = require("local")

require("castlelecs.case_converter_binding")
require("castlelecs.imports_sorting")
require("castlelecs.norgtemplate").setup(require("weekOpts"))
require("castlelecs.extract").setup()
require("castlelecs.sync").setup {
   items = {
      {
         path = "$HOME/notes/",
         auto_cmd = "BufWritePost",
         data = {
            git = require("git"),
         },
         sync_cmd = function(data)
            local utils = require("utils")
            local async = require("async")

            async.launch(function()
               local connection = utils.hasInternetConnection()

               if not connection then
                  vim.notify("Can't sync: no internet connection")
               end

               local isPullNeeded = data.git.hasAnythingToPull()

               if isPullNeeded then
                  data.git.autoPull().execute()
               end

               data.git
                  .add(locals.notesPath)
                  .amendCommit({
                     args = {
                        "--no-edit",
                        "--allow-empty",
                     },
                  })
                  .push({
                     args = {
                        "--force-with-lease",
                     },
                  })
                  .execute()
            end)
         end,
      },
   },
}

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

-- NOTE: Deprecate if not used
local notesModule = require("castlelecs.notes")
notesModule.setup {
   notesPath = locals.currentNotesPath,
   keymaps = {
      n = {
         ["<leader>n"] = notesModule.openLastNote,
      },
   },
}

require("castlelecs.gradle").setup {}
