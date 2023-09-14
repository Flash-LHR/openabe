.PHONY: all clean src

all: src

src:
	$(MAKE) -C src

install:
	mkdir -p $(INSTALL_PREFIX)/bin
	cp -r $(ZROOT)/root/lib $(INSTALL_PREFIX)
	cp -r $(ZROOT)/root/include $(INSTALL_PREFIX)
