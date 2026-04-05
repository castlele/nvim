vim.pack.add { "https://github.com/L3MON4D3/LuaSnip.git" }

local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node

-- Snippet jump keymaps

require("utils").setKeymaps {
   i = {
      ["<C-j>"] = function()
         if ls.expand_or_jumpable() then
            ls.expand_or_jump()
         end
      end,
      ["<C-k>"] = function()
         if ls.jumpable(-1) then
            ls.jump(-1)
         end
      end,
   },
   s = {
      ["<C-j>"] = function()
         if ls.expand_or_jumpable() then
            ls.expand_or_jump()
         end
      end,
      ["<C-k>"] = function()
         if ls.jumpable(-1) then
            ls.jump(-1)
         end
      end,
   },
}

-- Lua snippets

ls.add_snippets("lua", {
   s("classnew", {
      t("function "),
      i(1, "class_name"),
      t(":new("),
      i(2, "args"),
      t(")"),
      t { "", "\tlocal this = {}" },
      t { "", "", "\tsetmetatable(this, self)" },
      t { "", "", "\tself.__index = self" },
      t { "", "", "\treturn this" },
      t { "", "end" },
   }),
   s("it", {
      t('t.it("'),
      i(1, "test case name"),
      t('", function ()'),
      t { "", "end)" },
   }),
})

-- Kotlin snippets

ls.add_snippets("kotlin", {
   s("test", {
      t("@Test"),
      t { "", "" },
      t("fun `"),
      i(1, "Test name"),
      t("`() {"),
      t { "", "" },
      t("\tval expectedValue = "),
      i(2, "expected value"),
      t { "", "" },
      t("\tval sut = "),
      i(3, "system under test value"),
      t { "", "" },
      t { "", "" },
      t("\tval result = "),
      i(4, "testing..."),
      t { "", "" },
      t { "", "" },
      t("\tassertEquals(expectedValue, result)"),
      t { "", "" },
      t("}"),
   }),
   s("cmp", {
      t("@Composable"),
      t { "", "" },
      t("fun "),
      i(1, "Composable Name"),
      t("("),
      t { "", "" },
      t("\tmodifier: Modifier = Modifier,"),
      t { "", "" },
      t(") {"),
      t { "", "" },
      t("}"),
      t { "", "" },
   }),
})

-- CPP snippets

ls.add_snippets("cpp", {
   s("namespace", {
      t("namespace "),
      i(1, "name"),
      t(" {"),
      t { "", "" },
      t { "", "} // namespace " },
      f(function(args)
         return args[1][1]
      end, { 1 }),
   }),
   s("header", {
      d(1, function(_)
         local file = vim.fn.expand("%:t")
         local filecomps = vim.split(file, "%.")
         if #filecomps < 1 then
            return nil
         end
         local filename = string.upper(filecomps[1]) .. "_H_"
         return sn(1, {
            t { "#ifndef " .. filename, "" },
            t { "#define " .. filename, "" },
            t { "", "" },
            i(1, "content"),
            t { "", "" },
            t { "", "" },
            t { "#endif" },
         }, {})
      end, {}),
   }),
})

-- HTML snippets

ls.add_snippets("html", {
   s("start", {
      t("<!DOCTYPE html>"),
      t { "", "" },
      t("<html>"),
      t { "", "" },
      t("\t<head>"),
      t { "", "" },
      t("\t\t<title>"),
      i(1, "title name"),
      t("</title>"),
      t { "", "" },
      t('\t\t<meta charset="utf-8">'),
      t { "", "" },
      t("\t</head>"),
      t { "", "" },
      t("\t<body>"),
      t { "", "" },
      t("\t\t<main>"),
      t { "", "" },
      t("\t\t\t"),
      i(2, "content"),
      t { "", "" },
      t("\t\t</main>"),
      t { "", "" },
      t("\t</body>"),
      t { "", "" },
      t("</html>"),
   }),
})

-- Go snippets

ls.add_snippets("go", {
   s("test", {
      t("cases := []struct {"),
      t { "", "" },
      t("\t"),
      i(1, "configuration"),
      t { "", "" },
      t("}{"),
      t { "", "" },
      t("\t"),
      i(2, "init configuration"),
      t { "", "" },
      t("}"),
      t { "", "" },
      t { "", "" },
      t("for i, ts := range cases {"),
      t { "", "" },
      t('\tt.Run(fmt.Sprintf("test %v", i), func(t *testing.T) {'),
      t { "", "" },
      t("\t\tt.Parallel()"),
      t { "", "" },
      t("\t\tres := "),
      i(3, "call sut function"),
      t { "", "" },
      t { "", "" },
      t("\t\tif "),
      i(4, "test passing condition"),
      t(" {"),
      t { "", "" },
      t('\t\t\tt.Errorf("Expected: %v; got: %v", ts.output, res)'),
      t { "", "" },
      t("\t\t}"),
      t { "", "" },
      t("\t})"),
      t { "", "" },
      t("}"),
      t { "", "" },
   }),
})
