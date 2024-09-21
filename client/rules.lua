local awful = require("awful")
local beautiful = require("beautiful")
local clientkeys = require("client.clientkeys")
local clientbuttons = require("client.clientbuttons")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"Pcmanfm",
				"Pavucontrol",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true, placement = awful.placement.centered },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Browser TAG
	{ rule = { class = "firefox" }, properties = { screen = 1, tag = "1" } },
	-- Discord TAG
	{ rule = { class = "discord" }, properties = { screen = 1, tag = "2" } },
	-- Mail TAG
	{ rule = { class = "thunderbird" }, properties = { screen = 1, tag = "3" } },
	--Terminal TAG
	--{ rule = { class = terminal }, properties = { screen = 1, tag = terminalTag } },
	--Art TAG
	{ rule = { class = "libreoffice-writer" }, properties = { screen = 1, tag = "4" } },
	{ rule = { class = "libreoffice-impress" }, properties = { screen = 1, tag = "4" } },
	{ rule = { class = "Gimp-2.10" }, properties = { screen = 1, tag = "4" } },
	{ rule = { class = "Inkscape" }, properties = { screen = 1, tag = "4" } },
	{ rule = { class = "Blender" }, properties = { screen = 1, tag = "4" } },
}
-- }}}
