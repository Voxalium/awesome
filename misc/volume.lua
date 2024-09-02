local awful = require("awful")
local naughty = require("naughty")

function show_volume()
	local command = "sleep 0.1; wpctl get-volume @DEFAULT_AUDIO_SINK@"

	awful.spawn.easy_async_with_shell(command, function(out)
		local volume = tonumber(out:match("([%d%.]+)"))
		local percentage = math.floor(volume * 100 + 0.5)
		naughty.notify({ text = "Volume: " .. percentage, timeout = 1, replaces_id = 1 })
	end)
end

return {
	raise = awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell(" wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+")
		show_volume()
	end, { description = "Raise volume", group = "Volume" }),
	lower = awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell(" wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")
		show_volume()
	end, { description = "Lower volume", group = "Volume" }),
}
