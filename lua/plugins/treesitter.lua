return {
   "nvim-treesitter/nvim-treesitter",
   version = "v0.10.0",
   lazy = false,
   build = ':TSUpdate',
   config = function()
      require("nvim-treesitter.configs").setup {

         ensure_installed = {
            "go",
            "c",
            "cpp",
            "lua",
            "vimdoc",
            "vim",
            "norg",
            "kotlin",
            "java",
            "swift",
            "objc",
         },
         auto_install = true,
         highlight = { enable = true },
         indent = { enable = true },
      }
   end,
}
