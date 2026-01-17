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
            -- git add .
            -- git stash push
            -- git pull --no-edit
            -- git stash pop stash@{0}
            -- git commit --amend --no-edit --allow-empty
            -- git push --force-with-lease
            data.git
               .stashAll()
               .pull({
                  args = {
                     "--no-edit",
                  },
               })
               .applyTopStash()
               .add("/Users/castlelecs/notes/")
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
