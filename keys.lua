local awful = require("awful")
local gears = require("gears")
local modkey ="Mod4"
globalkeys = gears.table.join(
awful.key({modkey  }, "b" , function () awful.spawn.with_shell(browser) end,
              {description = "Launch Firefox", group = "Launcher"})
              )

