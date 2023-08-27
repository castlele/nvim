local lush = require('lush')

local hsl = lush.hsl

local theme = lush(function()
  return {
    Comment { fg=hsl("#EAEAEA").darken(40), gui="italic" },
    Normal { fg=hsl("#FFFFFF"), bg=hsl("#1A1A1A") },
    ColorColumn { bg=Normal.bg.lighten(10) },
    Type { Normal },
    Constant { fg=hsl("#9ED2C6").darken(10) },
    PreProc { fg=hsl("#BEADFA") },

    Identifier { fg=hsl("#C1EFFF").darken(30) },

    Statement { fg=hsl("#FFC4E1").darken(20), gui="bold" },

    Underline { fg=hsl("#BEADFA"), gui="underline bold" },
    Error { fg=hsl("#FF9B9B").darken(20), gui="underline bold" },
    Todo { fg=hsl("#FDFFAE"), gui="underline bold" },

    Special { fg=Todo.fg.darken(10) },

    Whitespace { fg = Comment.fg.darken(50) },
    SpecialKey { fg = Comment.fg.darken(50) },
    Cursorline { ColorColumn },
    LineNr { fg=Comment.fg.lighten(30) },
    CursorLineNr { fg=Todo.fg },
    MatchParen { gui="underline", bg=Special.fg },
    Search { bg=Underline.fg.darken(20) },
    Visual { Cursorline },
    SignColumn { },
    NonText { LineNr },
  }
end)

return theme
