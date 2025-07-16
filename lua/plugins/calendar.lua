return {
   "itchyny/calendar.vim",
   config = function()
      vim.g.calendar_cache_directory = "~/notes/calendar/"
      vim.g.calendar_cyclic_view = 1
      vim.g.calendar_first_day = "monday"
      vim.g.calendar_date_endian = "little"
      vim.g.calendar_date_separator = "."
   end,
}
