local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local taglist = require("ui.taglist")
local tasklist = require("ui.tasklist")
local set_wallpaper = require("ui.wallpaper")

local mytextclock = wibox.widget{
  format = "%A %e %B" ,
  font = "noto bold 10",
  widget = wibox.widget.textclock
}

local calendar = awful.widget.calendar_popup.month()
calendar:attach(mytextclock, "tc")

screen.connect_signal("property::geometry", set_wallpaper)
beautiful.init(awesomeDir .. "theme.lua")

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)
	awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[2])
  s.mypromptbox = awful.widget.prompt()
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(-1)
		end)
	))
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist,
		layout = { layout = wibox.layout.fixed.horizontal },
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 4,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			left = 10,
			right = 10,
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 28 })

	-- Add widgets to the wibox
	s.mywibox:setup({
		expand = "none",
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,
			--            mylauncher,
			s.mytaglist,
			s.mypromptbox,
			s.mytasklist,
		},
		mytextclock, -- Middle widget
		{ -- Right widgets
			spacing = 10,
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			s.mylayoutbox,
		},
	})
end)

screen.connect_signal("property::geometry", set_wallpaper)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
