#! /usr/bin/env sh
SCHEME=thunderlink
MIMETYPE="x-scheme-handler/${SCHEME}"
DESKTOP_FILE=thunderbird-thunderlink-handler.desktop
apps="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
if ! test -d "${apps}"
then
    mkdir -p "${apps}"
fi
desktop-file-install --dir="${apps}" "${DESKTOP_FILE}"
xdg-mime default "${DESKTOP_FILE}" "${MIMETYPE}"
if command gio 2> /dev/null
then
    gio mime "${MIMETYPE}" "${DESKTOP_FILE}"
fi
