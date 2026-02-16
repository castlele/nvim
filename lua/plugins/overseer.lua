return {
   "stevearc/overseer.nvim",
   config = function()
      local module = require("overseer")

      module.setup {}

      require("utils").setKeymaps {
         n = {
            ["<leader>R"] = module.run_task,
            ["<leader>Y"] = module.toggle,
         },
      }
   end,
}
