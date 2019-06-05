readme.html : readme.rst
	rst2html $< $@

DESKTOP:=thunderbird-thunderlink-handler.desktop
.PHONY : install
install : $(DESKTOP)
	./install-thunderlink.sh
