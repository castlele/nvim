---@type WeekConfiguration
local weekOpts = {
   week = {
      MON = {
         "work",
         "take care of Javie",
         "play with Javie",
      },
      TUE = {
         "work",
         "play with Javie",
      },
      WED = {
         "work",
         "clean the floors",
         "clean the office",
         "play with Javie",
      },
      THU = {
         "psychology session %13:00% - 1h",
         "work",
         "play with Javie",
      },
      FRI = {
         "work",
         "take care of Javie",
         "play with Javie",
      },
      SAT = {
         "call to grandmother",
         "play with Javie",
      },
      SUN = {
         "clean the floors",
         "clean the office",
         "fill stats",
         "play with Javie",
      },
   },
   sectionFooter = string.format(
      "%s\n%s\n%s",
      "goal:",
      "- %SMART goal%\n",
      "total: ",
      "result: "
   ),
   header = string.format(
      "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
      "@document.meta",
      "goal: [",
      "    %SMART goal%",
      "]",
      "stats: [",
      "    resting     : 0",
      "    work        : 0",
      "    uni         : 0",
      "    health      : 0",
      "    social      : 0",
      "    relationship: 0",
      "    projects    : 0",
      "    finances    : 0",
      "]",
      "@end"
   ),
}

return weekOpts
