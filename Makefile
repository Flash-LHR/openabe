.PHONY: all clean deps src bindings

all: check-env deps src

check-env:
ifndef ZROOT
    $(error ZROOT is undefined. Need to source env file: . ./env)
endif

INSTALL_PREFIX ?= /usr/local

docs:
	$(MAKE) -C docs

deps:
	$(MAKE) -C deps

src:
	$(MAKE) -C src

bindings:
	$(MAKE) -C bindings

install-deps:
	mkdir -p $(ZROOT)/deps/root/bin
	mkdir -p $(INSTALL_PREFIX)
	cp -r $(ZROOT)/deps/root/lib $(INSTALL_PREFIX)
	cp -r $(ZROOT)/deps/root/include $(INSTALL_PREFIX)
	cp -rn $(ZROOT)/deps/root/bin $(INSTALL_PREFIX)

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
