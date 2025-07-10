return {
   -- Support for vim api completions
   "folke/lazydev.nvim",
   ft = "lua",
   opts = {
      library = {
         path = "${3rd}/luv/library",
         words = {
            "vim%.uv",
         },
      },
   },
}
