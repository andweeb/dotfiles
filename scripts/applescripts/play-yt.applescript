tell application "Safari"
	set currentTab to current tab of front window
	if URL of currentTab starts with "https://www.youtube.com/watch" then
		tell current tab of front window
			do JavaScript "document.getElementsByClassName('ytp-play-button ytp-button')[0].click()"
		end tell
	else
		repeat with t in tabs of windows
			tell t
				if URL starts with "https://www.youtube.com/watch" then
					do JavaScript "document.getElementsByClassName('ytp-play-button ytp-button')[0].click()"
					exit repeat
				end if
			end tell
		end repeat
	end if
end tell