local strutils = require("cluautils.string_utils")

local actions = require("telescope.actions")
local layout = require("telescope.actions.layout")
local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local makeEntry = require("telescope.make_entry")
local conf = require("telescope.config").values

---@class TelescopeMethodsModule
local M = {}

local opts = {
   cwd = vim.uv.cwd(),
}

---@param mappings table
function M.setupTelescope(mappings)
   require("telescope").setup {
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
         mappings = mappings,
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
end

function M.loadExtensions()
   require("telescope").load_extension("fzf")
   require("telescope").load_extension("live_grep_args")
end

---@return table
function M.openSelectedInQlistAction()
   return actions.send_selected_to_qflist + actions.open_qflist
end

---@return fun(number)
function M.togglePreviewAction()
   return layout.toggle_preview
end

function M.findFilesOverProject()
   local ignore_files = {
      "%.git/",
      "build/",
      "bin/",
   }

   builtin.find_files {
      hidden = true,
      no_ignore = false,
      file_ignore_patterns = ignore_files,
   }
end

function M.searchOverCurrentFile()
   builtin.current_buffer_fuzzy_find {
      skip_empty_lines = true,
   }
end

function M.searchFileComponents()
   builtin.treesitter {
      symbols = {
         "var",
         "type",
         "function",
         "macro",
      },
   }
end

---@see TJs video for explanation https://www.youtube.com/watch?v=xdXE1tOT-qg
function M.multiSearch()
   local finder = finders.new_async_job {
      ---@type fun(prompt: string): table?
      command_generator = function(prompt)
         if not prompt or prompt:is_empty() then
            return nil
         end

         local pieces = strutils.split(prompt, "  ")
         local args = { "rg" }

         if pieces[1] then
            table.insert(args, "-e")
            table.insert(args, pieces[1])
         end

         if pieces[2] then
            table.insert(args, "-g")
            table.insert(args, pieces[2])
         end

         ---TODO: Move to cluautils in here
         return vim.tbl_flatten {
            args,
            {
               "--color=never",
               "--no-heading",
               "--with-filename",
               "--line-number",
               "--column",
               "--smart-case",
            },
         }
      end,
      entry_maker = makeEntry.gen_from_vimgrep(opts),
      cwd = opts.cwd,
   }

   pickers
      .new(opts, {
         debounce = 100,
         prompt_title = "Multi Search",
         finder = finder,
         previewer = conf.grep_previewer(opts),
         sorter = require("telescope.sorters").empty(),
      })
      :find()
end

---@param kbasePath string
function M.searchOverKBase(kbasePath)
   builtin.find_files {
      cwd = kbasePath,
      hidden = true,
      no_ignore = true,
      search_file = "*.md",
   }
end

function M.live_grep(...)
   require("telescope").extensions.live_grep_args.live_grep_args(...)
end

return M
