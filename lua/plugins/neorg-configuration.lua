require("neorg").setup {
   load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.keybinds"] = {
         config = {
            default_keybinds = true,
         },
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
         config = {
            workspaces = {
               notes = "~/time_tracking/notes",
            },
         },
      },
      ["core.export"] = {
         config = {
            export_dir = "~/Documents/neorg/",
         },
      },
      ["core.integrations.treesitter"] = {},
      ["core.ui.calendar"] = {},
      ["core.ui"] = {},
      ["core.esupports.metagen"] = { config = { update_date = false } }, -- do not update date until https://github.com/nvim-neorg/neorg/issues/1579 fixed
   },
}
