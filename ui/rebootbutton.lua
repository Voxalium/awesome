local awful = require("awful")
local beautiful = require("beautiful")
local myrebootmenu = awful.menu({
	items = {
		{ "Reboot", reboot },
		{ "Shutdown", shutdown },
	},
})

local myrebootbutton = awful.widget.button({
	image = beautiful.awesome_icon,
})
myrebootbutton:buttons(gears.table.join(
	myrebootbutton:buttons(),
	awful.button({}, 1, nil, function()
		myrebootmenu:toggle()
	end)
))

return myrebootbutton
