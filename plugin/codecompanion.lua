vim.pack.add {
   "https://github.com/olimorris/codecompanion.nvim.git",
   "https://github.com/nvim-lua/plenary.nvim.git",
   "https://github.com/nvim-treesitter/nvim-treesitter.git",
}

require("codecompanion").setup {
   adapters = {
      http = {
         x5_copilot = function()
            return require("codecompanion.adapters").extend(
               "openai_compatible",
               {
                  name = "x5_copilot",
                  formatted_name = "X5 Copilot",

                  env = {
                     url = "https://api-copilot.x5.ru/aigw/v1",
                     chat_url = "/chat/completions",
                     models_endpoint = "/models",

                     -- Priority:
                     -- 1) key set via :CodeCompanionSetX5ApiKey
                     -- 2) X5_COPILOT_API_KEY environment variable
                     api_key = function()
                        return vim.g.x5_copilot_api_key
                           or vim.env.X5_COPILOT_API_KEY
                     end,
                  },

                  headers = {
                     ["Content-Type"] = "application/json",
                     ["Authorization"] = "Bearer ${api_key}",
                  },

                  schema = {
                     model = {
                        default = "copilot-code-large",
                     },
                  },
               }
            )
         end,
      },
      ollama = function()
         return require("codecompanion.adapters").extend("ollama", {
            schema = {
               model = {
                  default = "qwen2.5-coder:7b",
               },
            },
         })
      end,
   },
   strategies = {
      chat = {
         adapter = "ollama",
      },
      inline = {
         adapter = "ollama",
      },
   },
}
