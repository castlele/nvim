local dailyTasks = {
   "do sport",
   "meditate",
   "read book",
   "reflex on thoughts",
}

---@type WeekConfiguration
local weekOpts = {
   week = {
      MON = {
         "work - 3h",
         "fill stats",
         "prepare next week file",
         "take care of Javie",
         daily = dailyTasks,
      },
      TUE = {
         "work - 3h",
         daily = {
            "do sport",
            "meditate",
            "read book",
            "reflex on thoughs",
         },
      },
      WED = {
         ["work - 3h"] = {
            "design demo",
         },
         "clean the floors",
         "clean the office",
         daily = dailyTasks,
      },
      THU = {
         "work - 3h",
         daily = dailyTasks,
      },
      FRI = {
         "psychology session %13:00% - 1h",
         "work - 3h",
         "take care of Javie",
         daily = dailyTasks,
      },
      SAT = {
         "followattr - 1h",
         "comeback - 30m",
         "call to grandmother",
         daily = dailyTasks,
      },
      SUN = {
         "followattr - 1h",
         "comeback - 30m",
         "clean the floors",
         "clean the office",
         "review goals",
         "review week",
         daily = dailyTasks,
      },
   },
   sectionFooter = string.format(
      "%s\n%s\n%s",
      "goal: %SMART goal%",
      "total: ",
      "result: "
   ),
   header = string.format(
      "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n",
      "@document.meta",
      "goal: %SMART goal%",
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
