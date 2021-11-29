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

		local format_string = same_day and "%H:%M" or "%H:%M (%A)"
		local formatted_time = os.date(format_string, end_time)
		-- Other variables
		local playlist_pos = mp.get_property_native("playlist-pos-1")
		local playlist_count = mp.get_property_native("playlist-count")
		local media_title = mp.get_property_native("media-title")
		local clock = mp.get_property_native("clock")
		local playtime_remaining = mp.get_property_osd("playtime-remaining")
		local time_pos = mp.get_property_osd("time_pos")
		local percent_pos = mp.get_property_osd("percent_pos")
		local duration = mp.get_property_osd("duration")

		--mp.osd_message("(" .. playlist_pos .. "/" .. playlist_count .. ") " .. media_title .. "\nPlayback speed: " .. playback_speed .. "\nSystem time is " .. clock .. "\nPlaytime remaining: " .. playtime_remaining .. "\nETA: " .. formatted_time, 5)
		--mp.set_property("osd-msg3", "(" .. playlist_pos .. "/" .. playlist_count .. ") " .. media_title .. "\n" .. time_pos .. " / " .. duration .. " (" .. percent_pos .. "%)" .. "\nSystem time is " .. clock .. "\nPlaytime remaining: " .. playtime_remaining .. "\nETA: " .. formatted_time, 2)
	else
		--mp.osd_message("Unable to estimate ending time")
	end
end

--mp.register_event("file-loaded", display_eta)
--mp.observe_property("speed", "number",  display_eta)
--mp.observe_property("osd-msg3", "string", display_eta)

--mp.add_key_binding("u", SCRIPT_COMMAND_NAME, display_eta, flags)
