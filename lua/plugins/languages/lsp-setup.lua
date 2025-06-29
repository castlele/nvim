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

