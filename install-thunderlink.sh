#! /usr/bin/env sh
apps="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
if ! test -d "${apps}"
then
    mkdir -p "${apps}"
fi
desktop-file-install --dir="${apps}" thunderbird-thunderlink-handler.desktop
xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'
if command gio 2> /dev/null
then
    gio mime x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop
fi
