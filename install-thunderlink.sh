#! /usr/bin/env sh

desktop-file-install thunderbird-thunderlink-handler.desktop
gio mime x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop
XDG_UTILS_DEBUG_LEVEL=2 xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'
