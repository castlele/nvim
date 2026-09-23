vim.pack.add { "https://github.com/echasnovski/mini.pick.git" }

local picker = require("mini.pick")

picker.setup {
  mappings = {
    mark_all = "<C-q>",
  },
}

require("utils").setKeymaps {
  n = {
    -- TODO: Make names for keymaps more obvious
    ["<leader>O"] = picker.builtin.files,
    ["<leader>IO"] = function()
      picker.builtin.cli({
        command = {
          "rg",
          "--files",
          "--color=never",
          "-uu",
        },
      }, {
        source = {
          name = "Files with gitignore",
        },
      })
    end,
    ["<leader>F"] = picker.builtin.grep_live,
    ["<leader>H"] = picker.builtin.help,
    ["<leader>G"] = function()
      picker.builtin.cli({
        command = {
          "git", "ls-files",
          "--modified", "--others", "--exclude-standard", "--deduplicate",
        },
      }, {
        source = { name = "Git changed files" },
      })
    end,
    ["<leader>fkb"] = function()
      picker.builtin.files(nil, {
        source = {
          cwd = require("local").kbasePath,
        },
      })
    end,
  },
}
