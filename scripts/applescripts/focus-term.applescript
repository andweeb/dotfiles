-- Focus existing open terminals giving priority to alacritty, iTerm2, then Terminal
tell application "System Events"
	if application process "alacritty" exists then
		tell application "System Events" to set frontmost of process "alacritty" to true
	else if application process "iTerm2" exists then
		tell application "System Events" to set frontmost of process "iTerm2" to true
	else if application process "Terminal" exists then
		tell application "System Events" to set frontmost of process "Terminal" to true
	end if
end tell
