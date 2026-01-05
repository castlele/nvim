---@type WeekConfiguration
local weekOpts = {
   week = {
      MON = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         "work",
         "set week goals",
         "take care of Javie",
      },
      TUE = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         "work",
      },
      WED = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         "work",
      },
      THU = {
         "play with Javie",
         "check how tasks align with goals",
         "psychology session %13:00% - 1h",
         "work",
         "clean the floors",
         "clean the office",
      },
      FRI = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         "work",
         "take care of Javie",
      },
      SAT = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         "call to grandmother",
      },
      SUN = {
         "play with Javie",
         "check how tasks align with goals",
         "clean the floors",
         "clean the office",
         "fill stats",
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
