function sd --description "Quick PHP server"
    systemd-run --user --scope sng --behavior zend $@
end
