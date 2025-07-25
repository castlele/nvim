return {
   "numToStr/Comment.nvim",
   config = function()
      require("Comment").setup {
         toggler = {
            line = "<C-_>",
         },
         opleader = {
            line = "<C-_>",
         },
         mappings = {
            extra = false,
         },
      }

      local ft = require("Comment.ft")

      ft({ "objc", "objcpp" }, "// %s")
   end,
}
