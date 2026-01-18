local function navigateToCurrentWeekDay()
   local weekday = os.date("%a")

   if type(weekday) ~= "string" then
      return
   end

   local capitalized = string.upper(weekday)
   local found = vim.fn.search(capitalized)

   if found ~= 0 then
      vim.cmd("normal! zt'")
   end
end

vim.keymap.set("n", "<space>r", "<cmd>Neorg toggle-concealer<CR>", {
   desc = "Update layout (toggle concealer)",
   buffer = true,
})

vim.keymap.set("n", "<space><space>", navigateToCurrentWeekDay, {
   desc = "Navigate to current weekday",
   buffer = true,
})
