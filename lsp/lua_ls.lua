local tableutils = require("cluautils.table_utils")
local mason_registry = require('mason-registry')
local mason_path = require('mason-core.path')

local function get_mason_bin_path(server_name)
  -- Check if the package is installed
  if not mason_registry.is_installed(server_name) then
    vim.notify(('Mason: %s is not installed'):format(server_name), vim.log.levels.WARN)
    return nil
  end

  -- Get package info
  local pkg = mason_registry.get_package(server_name)

  -- Get the primary executable (usually the first one in bin)
  local bin_name = pkg.spec.bin[1] or server_name
  if vim.fn.has('win32') == 1 then
    bin_name = bin_name .. '.exe'
  end

  -- Construct full path
  return mason_path.bin_prefix(bin_name)
end

local packages = {
   "~/.luaver/luarocks/2.3.0_5.1/share/lua/5.1",
   "~/.luaver/luarocks/3.0.0_5.1/share/lua/5.1",
   "${3rd}/love2d/library",
}

return {
   cmd = { get_mason_bin_path("lua-language-server") },
   root_markers = { ".git" },
   filetypes = { "lua" },
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
            library = tableutils.concat_tables(
               vim.api.nvim_get_runtime_file("", true),
               packages
            ),
            checkThirdParty = false,
            telemetry = { enable = false },
         },
         completion = { callSnippet = "Replace" },
         diagnostics = { globals = { "vim" } },
      },
   },
}
