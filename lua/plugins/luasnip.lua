---@param ls table
---@param keymaps table?
local function setKeymaps(ls, keymaps)
   if not keymaps then
      return
   end

   local keysetter = require("utils").keymap_func

   for mode, combs in pairs(keymaps) do
      assert(type(mode) == "string")
      assert(type(combs) == "table")

      for key, fun in pairs(combs) do
         assert(type(key) == "string")
         assert(type(fun) == "function")

         keysetter(mode, key, fun(ls))
      end
   end
end

local function echo(args, _, _)
   return args[1][1]
end

---@class LuaSnipModule
local M = {}

---@class LuaSnipModuleConfig
---@field keymaps table?
---@param config LuaSnipModuleConfig
function M.setup(config)
   local ls = require("luasnip")

   local s = ls.snippet
   local t = ls.text_node
   local i = ls.insert_node
   local f = ls.function_node

   setKeymaps(ls, config.keymaps)

   -- Lua snippents

   ls.add_snippets("lua", {
      s("classnew", {
         t("function "), i(1, "class_name"), t(":new("), i(2, "args"), t(")"),
         t({ "", "\tlocal this = {}" }),
         t({ "", "", "\tsetmetatable(this, self)" }),
         t({ "", "", "\tself.__index = self" }),
         t({ "", "", "\treturn this" }),
         t({ "", "end" }),
      })
   })

   ls.add_snippets("lua", {
      s("it", {
         t("t.it(\""), i(1, "test case name"), t("\", function ()"),
         t({ "", "end)" })
      })
   })

   -- CPP snippets

   ls.add_snippets("cpp", {
      s("namespace", {
         t("namespace "), i(1, "name"), t(" {"),
         t({"", ""}),
         t({"", "} // namespace "}), f(echo, {1}),
      })
   })

   -- html snippets

   ls.add_snippets("html", {
      s("start", {
         t("<!DOCTYPE html>"), t({"", ""}),
         t("<html>"), t({"", ""}),
         t("\t<head>"), t({"", ""}),
         t("\t\t<title>"), i(1, "title name"), t("</title>"), t({"", ""}),
         t("\t\t<meta charset=\"utf-8\">"), t({"", ""}),
         t("\t</head>"), t({"", ""}),
         t("\t<body>"), t({"", ""}),
         t("\t\t<main>"), t({"", ""}),
         t("\t\t\t"), i(2, "content"), t({"", ""}),
         t("\t\t</main>"), t({"", ""}),
         t("\t</body>"), t({"", ""}),
         t("</html>"),
      })
   })
end

return M
