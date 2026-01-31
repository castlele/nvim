local function setupJavaLsp()
   local function get_jdtls_cache_dir()
      return vim.fn.stdpath("cache") .. "/jdtls"
   end

   local function get_jdtls_workspace_dir()
      return get_jdtls_cache_dir() .. "/workspace"
   end

   local workspace_dir = get_jdtls_workspace_dir()

   vim.lsp.config("jdtls", {
      cmd = {
         "jdtls",
         "-data",
         workspace_dir,
         cmd = {
            "jdtls",
            "-data",
            workspace_dir,
            "--jvm-arg=-XX:+UseParallelGC",
            "--jvm-arg=-XX:GCTimeRatio=4",
            "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
            "--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
            "--jvm-arg=-Xmx1G",
            "--jvm-arg=-Xms500m",
            "--jvm-arg=-Xlog:disable",
            "--jvm-arg=-javaagent:" .. "jdtls" .. "/lombok.jar",
         },
      },
   })
end

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
      vim.lsp.enable("gdscript")
      vim.lsp.enable("sourcekit")
      setupJavaLsp()

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

      vim.lsp.config("sourcekit", {
         settings = {
            filetypes = { "swift", "objc", "objcpp" },
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
