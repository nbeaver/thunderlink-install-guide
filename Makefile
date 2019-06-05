readme.html : readme.rst
	rst2html $< $@

DESKTOP:=thunderbird-thunderlink-handler.desktop
.PHONY : install
install : $(DESKTOP)
	desktop-file-install $(DESKTOP)
	# TODO: are these lines necessary?
	-gio mime x-scheme-handler/thunderlink $(DESKTOP)
	-xdg-mime default $(DESKTOP) 'x-scheme-handler/thunderlink'
