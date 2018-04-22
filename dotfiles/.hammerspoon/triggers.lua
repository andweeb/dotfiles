---------------------------------------
-- Keyboard Triggers for HammerSpoon --
---------------------------------------
hs.hotkey.bind({'alt', 'cmd', 'shift'}, 'r', function() hs.reload() end)

-----------------------
-- Open Applications --
-----------------------
hs.hotkey.bind({'alt'}, '.', function() hs.application.launchOrFocus('Activity Monitor') end)
hs.hotkey.bind({'alt'}, 'a', function() hs.application.launchOrFocus('Messages') end)
hs.hotkey.bind({'alt'}, 'i', function() hs.application.launchOrFocus('iTunes') end)
hs.hotkey.bind({'alt'}, 'n', function() hs.application.launchOrFocus('TextEdit') end)
hs.hotkey.bind({'alt'}, 'p', function() hs.application.launchOrFocus('Preview') end)
hs.hotkey.bind({'alt'}, 'w', function() hs.application.launchOrFocus('Microsoft Word') end)
hs.hotkey.bind({'alt'}, 'x', function() hs.application.launchOrFocus('Xcode') end)
hs.hotkey.bind({'alt', 'cmd'}, '/', function() hs.application.launchOrFocus('Terminal') end)
hs.hotkey.bind({'alt', 'cmd'}, 'g', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind({'alt', 'cmd'}, 's', function() hs.application.launchOrFocus('Slack') end)
hs.hotkey.bind({'alt', 'cmd'}, 'v', function() hs.application.launchOrFocus('VMware Fusion') end)
hs.hotkey.bind({'alt', 'shift'}, 'c', function() hs.application.launchOrFocus('Fantastical 2') end)
hs.hotkey.bind({'alt', 'shift'}, 'd', function() hs.application.launchOrFocus('Discord') end)
hs.hotkey.bind({'alt', 'shift'}, 'i', function() hs.application.launchOrFocus('IINA') end)
hs.hotkey.bind({'alt', 'shift'}, 'n', function() hs.application.launchOrFocus('Notes') end)
hs.hotkey.bind({'alt', 'shift'}, 'p', function() hs.application.launchOrFocus('Postico') end)
hs.hotkey.bind({'alt', 'shift'}, 's', function() hs.application.launchOrFocus('Spotify') end)
hs.hotkey.bind({'alt', 'cmd', 'shift'}, 'a', function() hs.application.launchOrFocus('Alacritty') end)
hs.hotkey.bind({'alt', 'cmd', 'shift'}, 'f', function() hs.application.launchOrFocus('Finder') end)
hs.hotkey.bind({'alt', 'cmd', 'shift'}, 'h', function() hs.application.launchOrFocus('Hammerspoon') end)
hs.hotkey.bind({'alt', 'cmd', 'shift'}, 's', function() hs.application.launchOrFocus('Safari') end)

---------------
-- Open URLs --
---------------
hs.hotkey.bind({'alt'}, 'b', function() hs.urlevent.openURL('https://bankofamerica.com') end)
hs.hotkey.bind({'alt'}, 'f', function() hs.urlevent.openURL('https://facebook.com/messages') end)
hs.hotkey.bind({'alt'}, 'g', function() hs.urlevent.openURL('https://google.com') end)
hs.hotkey.bind({'alt'}, 'h', function() hs.urlevent.openURL('https://hangouts.google.com') end)
hs.hotkey.bind({'alt'}, 'k', function() hs.urlevent.openURL('https://www.kadenze.com/courses') end)
hs.hotkey.bind({'alt'}, 'l', function() hs.urlevent.openURL('https://www.linkedin.com') end)
hs.hotkey.bind({'alt'}, 'm', function() hs.urlevent.openURL('https://mail.google.com') end)
hs.hotkey.bind({'alt'}, 'r', function() hs.urlevent.openURL('https://reddit.com') end)
hs.hotkey.bind({'alt'}, 't', function() hs.urlevent.openURL('https://tumblr.com') end)
hs.hotkey.bind({'alt'}, 'y', function() hs.urlevent.openURL('https://youtube.com') end)
hs.hotkey.bind({'alt'}, '1', function() hs.urlevent.openURL('https://amazon.com') end)
hs.hotkey.bind({'alt', 'cmd'}, 'd', function() hs.urlevent.openURL('https://drive.google.com') end)
hs.hotkey.bind({'alt', 'cmd'}, 'm', function() hs.urlevent.openURL('https://medium.com') end)
hs.hotkey.bind({'alt', 'cmd'}, 'y', function() hs.urlevent.openURL('https://www.yelp.com') end)
hs.hotkey.bind({'alt', 'shift'}, 'f', function() hs.urlevent.openURL('https://facebook.com') end)
hs.hotkey.bind({'alt', 'shift'}, 'g', function() hs.urlevent.openURL('https://github.com') end)
hs.hotkey.bind({'alt', 'shift'}, 'h', function() hs.urlevent.openURL('https://news.ycombinator.com') end)
hs.hotkey.bind({'alt', 'shift'}, 'm', function() hs.urlevent.openURL('https://google.com/maps') end)

------------------
-- Open Folders --
------------------
local openFolder = function(dirname)
    hs.execute('open ' .. dirname)
end

hs.hotkey.bind({'alt'}, 'd', function() openFolder('$HOME/Downloads') end)
hs.hotkey.bind({'alt'}, 'v', function() openFolder('$HOME/Movies') end)

----------------------
-- Run AppleScripts --
----------------------
hs.hotkey.bind(
    {'alt'},
    '/',
    function()
        hs.osascript.applescriptFromFile(
            os.getenv('HOME') .. '/dotfiles/scripts/applescripts/focus-term.applescript'
        )
    end
)
hs.hotkey.bind(
    {'alt', 'cmd'},
    'p',
    function()
        hs.osascript.applescriptFromFile(
            os.getenv('HOME') .. '/dotfiles/scripts/applescripts/safari-play-yt.applescript'
        )
    end
)
hs.hotkey.bind(
    {'alt', 'cmd'},
    'n',
    function()
        hs.osascript.applescriptFromFile(
            os.getenv('HOME') .. '/dotfiles/scripts/applescripts/safari-next-yt.applescript'
        )
    end
)
hs.hotkey.bind(
    {'alt', 'cmd', "shift"},
    'g',
    function()
        hs.osascript.applescriptFromFile(
            os.getenv('HOME') .. '/dotfiles/scripts/applescripts/open-chrome-incognito.applescript'
        )
    end
)
