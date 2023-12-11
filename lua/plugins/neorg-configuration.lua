require("neorg").setup {
   load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.keybinds"] = {
         config = {
            default_keybinds = true,
            neorg_leader = ",",
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
            export_dir = "~/Documents/neorg/"
         },
      },
      ["core.integrations.treesitter"] = {
      },
   },
}
