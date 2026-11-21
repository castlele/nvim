vim.pack.add {
  "https://github.com/nvim-telescope/telescope.nvim.git",
  "https://github.com/nvim-telescope/telescope-live-grep-args.nvim.git",
  "https://github.com/nvim-telescope/telescope-fzy-native.nvim.git",
}

local telescope = require("telescope")
local actions = require("telescope.actions")


local function findFilesOverProject()
  local ignore_files = {
    "%.git/",
    "build/",
    "bin/",
  }

  require("telescope.builtin").find_files {
    hidden = true,
    no_ignore = false,
    file_ignore_patterns = ignore_files,
  }
end

local function searchOverCurrentFile()
  require("telescope.builtin").current_buffer_fuzzy_find {
    skip_empty_lines = true,
  }
end

local function searchFileComponents()
  require("telescope.builtin").treesitter {
    symbols = {
      "var",
      "type",
      "function",
      "macro",
    },
  }
end

---@param kbasePath string
local function searchOverKBase(kbasePath)
  require("telescope.builtin").find_files {
    cwd = kbasePath,
    hidden = true,
    no_ignore = true,
    search_file = "*.md",
  }
end

local function live_grep(...)
  require("telescope").extensions.live_grep_args.live_grep_args(...)
end

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        width = { padding = 0 },
        height = { padding = 0 },
        preview_width = 0.7,
      },
    },
    path_display = {
      "filename_first",
    },
  },
  extensions = {
    fzf = {
      -- false will only do exact matching
      fuzzy = true,
      -- override the generic sorter
      override_generic_sorter = true,
      -- override the file sorter
      override_file_sorter = true,
      -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
      case_mode = "smart_case",
    },
  },
}

telescope.load_extension("fzy_native")
telescope.load_extension("live_grep_args")

require("utils").setKeymaps {
  n = {
    ["<space>fc"] = searchFileComponents,
    ["<leader>O"] = findFilesOverProject,
    ["<leader>F"] = live_grep,
    ["<leader>f"] = searchOverCurrentFile,
    ["<leader>fkb"] = function()
      searchOverKBase(require("local").kbasePath)
    end,
  },
}
