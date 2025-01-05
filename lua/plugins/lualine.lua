local colors = {
   bg = "#272b34",
   fg = "#dedede",
   pink = "#ff66b0",
   yellow = "#feffad",
   purple = "#beadfa",
   search = "#adadad",
}

local castlelecsscheme = {
   normal = {
      a = { fg = colors.bg, bg = colors.pink },
      b = { fg = colors.bg, bg = colors.purple },
      c = { fg = colors.fg, bg = colors.bg },

      x = { fg = colors.fg, bg = colors.bg },
      y = { fg = colors.fg, bg = colors.bg },
      z = { fg = colors.fg, bg = colors.bg },
   },
   insert = {
      a = { fg = colors.bg, bg = colors.yellow },
      b = { fg = colors.bg, bg = colors.purple },

      x = { fg = colors.fg, bg = colors.bg },
      y = { fg = colors.fg, bg = colors.bg },
   },
   visual = {
      a = { fg = colors.bg, bg = colors.purple },
      b = { fg = colors.bg, bg = colors.purple },

      x = { fg = colors.fg, bg = colors.bg },
      y = { fg = colors.fg, bg = colors.bg },
   },
   command = {
      a = { fg = colors.bg, bg = colors.purple },
      b = { fg = colors.bg, bg = colors.purple },

      x = { fg = colors.fg, bg = colors.bg },
      y = { fg = colors.fg, bg = colors.bg },
   },
   inactive = {
      b = { fg = colors.fg, bg = colors.bg },
   },
}

require("lualine").setup {
   options = {
      theme = castlelecsscheme,
      component_separators = "|",
      section_separators = { left = "", right = "" },
   },
   sections = {
      lualine_a = {
         {
            "mode",
            separator = { left = "", right = "" },
         },
      },
      lualine_b = {},
      lualine_c = { "branch" },
      lualine_x = { "diagnostics" },
      lualine_y = { "diff", "progress" },
      lualine_z = { "location" },
   },
   tabline = {
      lualine_a = {},
      lualine_b = {
         {
            "tabs",
            mode = 0,
            use_mode_colors = true,
            separator = { left = "", right = "" },
         },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
         {
            "filename",
            path = 1,
         },
      },
      lualine_z = {},
   },
   extensions = {},
}
