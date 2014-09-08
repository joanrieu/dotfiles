function run --description 'Run through user-mode systemd'
	systemd-run --user $argv
end
