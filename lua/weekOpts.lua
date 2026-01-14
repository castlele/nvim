---@type WeekConfiguration
local weekOpts = {
   week = {
      MON = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         work = {
            "log time",
         },
         "set week goals",
         "take care of Javie",
         "go for a walk",
      },
      TUE = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         work = {
            "log time",
         },
         "go for a walk",
      },
      WED = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         work = {
            "log time",
         },
         "go for a walk",
      },
      THU = {
         "play with Javie",
         "check how tasks align with goals",
         "psychology session %13:00% - 1h",
         "job hunting routine",
         work = {
            "log time",
         },
         "clean the floors",
         "clean the office",
         "go for a walk",
      },
      FRI = {
         "play with Javie",
         "check how tasks align with goals",
         "job hunting routine",
         work = {
            "log time",
         },
         "take care of Javie",
         "go for a walk",
      },
      SAT = {
         "play with Javie",
         "check how tasks align with goals",
         "call to grandmother",
         "go for a walk",
      },
      SUN = {
         "play with Javie",
         "check how tasks align with goals",
         "clean the floors",
         "clean the office",
         "go for a walk",
         "fill stats",
      },
   },
   sectionFooter = string.format(
      "%s\n%s\n%s",
      "goal:",
      "- %SMART goal%\n",
      "total: "
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
