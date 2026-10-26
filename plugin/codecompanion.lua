vim.pack.add {
  "https://github.com/olimorris/codecompanion.nvim.git",
  "https://github.com/nvim-lua/plenary.nvim.git",
}

require("codecompanion").setup {
  adapters = {
    acp = {
      --- npm install -g @zed-industries/claude-agent-acp
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = require("local").claudeOAuthToken
          }
        })
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
  interactions = {
    chat = {
      adapter = "claude_code",
      model = "sonnet",
    },
    inline = {
      adapter = "claude_code",
      model = "sonnet",
    },
  },
}
