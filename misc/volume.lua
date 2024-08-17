local awful = require("awful")
local naughty = require("naughty")

function show_volume()
	local command = "sleep 0.1; pamixer --get-volume"
	awful.spawn.easy_async_with_shell(command, function(out)
		naughty.notify({ text = "Volume: " .. out, timeout = 1, replaces_id = 1 })
	end)
end

return {
	raise = awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell(" pamixer -i 2")
		show_volume()
	end, { description = "Raise volume", group = "Volume" }),
	lower = awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell(" pamixer -d 2")
		show_volume()
	end, { description = "Lower volume", group = "Volume" }),
}
