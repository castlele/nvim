local hsb = require("utils").hsbToHex

local colors = {
   bglight = "#586074",
   bg = "#272b34",
   bgdark = "#21242c",
   green = "#b3f6c0",
   greenpaledark = "#387a6b",
   white = "#dedede",
   pink = "#ff66b0",
   yellow = "#feffad",
   purple = "#beadfa",
   red = "#ff471a",
   orangelight = "#ffd9b3",
   orange = "#ffa64d",
   search = "#adadad",
   blue = "#8cf8f7",
   grey = "#494a50",
   greylight = "#9b9ea4",
   dark = "#141414",
}

colors.base0 = hsb(223, 0, 87) -- starting from linght gray
colors.base1 = hsb(223, 24, 70)
colors.base2 = hsb(223, 24, 45)
-- #262a33
colors.base3 = hsb(223, 25, 20) -- common bg of mine
-- #21242b
colors.base4 = hsb(223, 25, 17)
-- #141414
colors.base5 = hsb(223, 0, 8)   -- finishing almoust black

--- pink
colors.accent0 = hsb(315, 27, 96)
--- green (mint)
colors.accent1 = hsb(132, 27, 96)
--- yellow
colors.accent2 = hsb(61, 27, 96)
--- purple
colors.accent3 = hsb(253, 27, 96)
--- pale red
colors.accent4 = hsb(359, 27, 96)

--- blue
colors.diagnostics0 = hsb(202, 67, 95)
--- orange
colors.diagnostics1 = hsb(37, 67, 95)
--- red
colors.diagnostics2 = hsb(359, 67, 95)

return colors
