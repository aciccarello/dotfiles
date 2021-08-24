
###############################################################################
# Kill affected applications                                                  #
###############################################################################
echo 'Restarting apps...'

for app in "Dock" \
	"Finder" \
    "SystemUIServer" \
	"Safari" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
# kill -9 $(pgrep Electron) # VS Code