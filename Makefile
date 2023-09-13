.PHONY: all clean src

all: check-env src

check-env:
ifndef ZROOT
    $(error ZROOT is undefined. Need to source env file: . ./env)
endif

INSTALL_PREFIX ?= /usr/local

docs:
	$(MAKE) -C docs

src:
	$(MAKE) -C src

install: install-deps
	mkdir -p $(INSTALL_PREFIX)/bin
	cp -r $(ZROOT)/root/lib $(INSTALL_PREFIX)
	cp -r $(ZROOT)/root/include $(INSTALL_PREFIX)
	
clean:
	$(MAKE) -C src clean
	$(RM) -rf $(ZROOT)/deps/root
	$(RM) -rf $(ZROOT)/root/lib/* $(ZROOT)/root/include/*

distclean:	clean
	$(MAKE) -C deps distclean
