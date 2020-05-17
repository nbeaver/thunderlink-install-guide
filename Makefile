.PHONY: all
all : readme.html install-standalone.sh

readme.html : readme.rst
	rst2html $< $@

DESKTOP:=thunderbird-thunderlink-handler.desktop
.PHONY : install
install : $(DESKTOP)
	./install-thunderlink.sh

install-standalone.sh : install-standalone.pre.sh thunderbird-thunderlink-handler.desktop
	m4 install-standalone.pre.sh > $@

clean :
	rm -f -- readme.html install-standalone.sh
