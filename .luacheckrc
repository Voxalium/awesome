---@diagnostic disable: lowercase-global

self = false
ignore = {
	"111", -- setting non-standard global variable
	"113",
	"212/_.*", -- unused argument, for vars with "_" prefix
	"214", -- used variable with unused hint ("_" prefix)
	"121", -- setting read-only global variable 'vim'
	"122", -- setting read-only field of global variable 'vim'
}

read_globals = {
	"awesome",
	"rc",
	"client",
}
