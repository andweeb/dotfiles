tell application "Safari"
	tell current tab of front window
		do JavaScript "(
			function () {
				for (var i = 0, l = document.all.length; i < l; ++i) {
					document.all[i].style.tabSize = 4;
				}
			}
		)()"
	end tell
end tell
