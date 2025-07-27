local function searchOverKBase(kbasePath)
   require("telescope.builtin").find_files {
      cwd = kbasePath,
      hidden = true,
      no_ignore = true,
      search_file = "*.md",
   }
end

return {
   'echasnovski/mini.pick',
   version = false,
   config = function()
      local picker = require("mini.pick")

      picker.setup()

      require("utils").setKeymaps {
         n = {
            ["<leader>O"] = picker.builtin.files,
            ["<leader>F"] = picker.builtin.grep_live,
            ["<leader>fkb"] = function ()
               picker.builtin.files(nil, {
                  source = {
                     cwd = require("local").kbasePath
                  }
               })
            end,
         },
      }
   end,
}
