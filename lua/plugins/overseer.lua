return {
   "stevearc/overseer.nvim",
   config = function()
      local module = require("overseer")

      module.setup {}

      local uv = vim.loop
      local cwd = vim.fn.getcwd()
      local isGradleProject = uv.fs_stat(cwd .. "/settings.gradle")
         or uv.fs_stat(cwd .. "/settings.gradle.kts")

      if isGradleProject then
         module.register_template {
            name = "android run",
            builder = function()
               return {
                  cmd = { "./gradlew", "installDebug" },
               }
            end,
         }
      end

      require("utils").setKeymaps {
         n = {
            ["<leader>R"] = module.run_task,
            ["<leader>Y"] = module.toggle,
         },
      }
   end,
}
