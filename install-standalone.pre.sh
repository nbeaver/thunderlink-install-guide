#! /usr/bin/env bash

cat << 'EOF' > ~/.local/share/applications/thunderbird-thunderlink-handler.desktop
changequote(`<<<', `>>>')
include(<<<thunderbird-thunderlink-handler.desktop>>>)
EOF

chmod +x ~/.local/share/applications/thunderbird-thunderlink-handler.desktop

xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'

update-desktop-database ~/.local/share/applications
