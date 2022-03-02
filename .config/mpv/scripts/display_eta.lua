--[[
	Simple script to display the end-time for the current file.
	Example input.conf bind:
	E script-message display-eta
]]--
local utils = require("mp.utils")

local SCRIPT_COMMAND_NAME = 'display-eta'

function display_eta()
	local playback_time = mp.get_property_native("playback-time")
	local duration = mp.get_property_native("duration")

	if playback_time and duration then
		local playback_speed = mp.get_property_native("speed")
		local remaining_time = (duration - playback_time) / playback_speed

		local current_time = os.time()
		local end_time = current_time + remaining_time

		-- Check if the date changes and adjust the format string
		local current_time_table = os.date("*t", current_time)
		local end_time_table = os.date("*t", end_time)
		local same_day = current_time_table.year == end_time_table.year and current_time_table.month == end_time_table.month and current_time_table.day == end_time_table.day

		local format_string = same_day and "%H:%M %p" or "%H:%M %p (%A)"
		local formatted_time = os.date(format_string, end_time)

	--	mp.osd_message("Speed: " .. playback_speed .."x" .. "\nSystem Time: " .. os.date("%H:%M %p") ..  "\nETA: " .. formatted_time .. "\nPlaytime remaining: " .. mp.get_property_osd("playtime-remaining"))
		mp.osd_message("(" .. mp.get_property_osd("playlist-pos-1") .. "/" .. mp.get_property_osd("playlist-count") .. ")" .. mp.get_property_osd("media-title") .. "\nSpeed: " .. playback_speed .."x" .. "\nSystem Time: " .. os.date("%H:%M %p") ..  "\nETA: " .. formatted_time .. "\nPlaytime remaining: " .. mp.get_property_osd("playtime-remaining"))
	else
		mp.osd_message("Unable to estimate ending time")
	end
end

mp.add_key_binding("y", SCRIPT_COMMAND_NAME, display_eta)
