#! /usr/bin/env sh
SCHEME=thunderlink
MIMETYPE="x-scheme-handler/${SCHEME}"
DESKTOP_FILEPATH=thunderbird-thunderlink-handler.desktop
DESKTOP_FILENAME=$(basename "${DESKTOP_FILEPATH}")
apps="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
if ! test -d "${apps}"
then
    mkdir -p "${apps}"
fi
desktop-file-install --dir="${apps}" "${DESKTOP_FILEPATH}"
xdg-mime default "${DESKTOP_FILENAME}" "${MIMETYPE}"
if command gio 2> /dev/null
then
    gio mime "${MIMETYPE}" "${DESKTOP_FILENAME}"
fi
