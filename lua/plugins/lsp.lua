return {
   "neovim/nvim-lspconfig",
   dependencies = {
      { "mason-org/mason.nvim", opts = true },
      {
         "mason-org/mason-lspconfig.nvim",
         opts = {
            ensure_installed = {
               "lua_ls",
               "clangd",
               "gopls",
               "html",
               "jdtls",
               "kotlin_language_server",
               "marksman",
            },
         },
      },
   },
   config = function()
      vim.lsp.enable("sourcekit")

      local packages = {
         "~/.luaver/luarocks/2.3.0_5.1/share/lua/5.1",
         "~/.luaver/luarocks/3.0.0_5.1/share/lua/5.1",
         "${3rd}/love2d/library",
      }

      vim.lsp.config("lua_ls", {
         settings = {
            Lua = {
               runtime = {
                  version = "LuaJIT",
                  path = {
                     "?.lua",
                     "?/init.lua",
                  },
               },
               format = {
                  enable = true,
                  defaultConfig = {
                     indent_style = "space",
                     indent_size = "3",
                  },
               },
               workspace = {
                  library = packages,
                  checkThirdParty = false,
                  telemetry = { enable = false },
               },
               completion = { callSnippet = "Replace" },
               diagnostics = { globals = { "vim" } },
            },
         },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
         callback = function(event)
            local opts = { buffer = event.buf, silent = true }

            require("utils").setKeymaps {
               n = {
                  ["gD"] = vim.lsp.buf.declaration,
                  ["gd"] = vim.lsp.buf.definition,
                  ["gr"] = vim.lsp.buf.references,
                  ["K"] = vim.lsp.buf.hover,
                  ["<C-K>"] = vim.lsp.buf.code_action,
                  ["<leader>rn"] = vim.lsp.buf.rename,
                  ["<leader>e"] = vim.diagnostic.open_float,
               },
               i = {
                  ["<C-S>"] = vim.lsp.buf.signature_help,
               },
            }

            -- TODO: Research msason formatters
            vim.keymap.set("n", "<space>f", function()
               vim.lsp.buf.format { async = true }
            end, opts)
         end,
      })

      vim.cmd("set completeopt+=noselect")
      vim.diagnostic.config {
         virtual_lines = { current_line = true },
      }
   end,
}
