tell application "System Events"
	if application process "alacritty" exists then
		tell application "System Events" to set frontmost of process "alacritty" to true
	else
		do shell script "$HOME/Sites/alacritty/target/release/alacritty"
	end if
end tell