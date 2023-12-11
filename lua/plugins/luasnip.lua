local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local tab = "   "

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
