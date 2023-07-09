
ZSYMLIB = libzsym.a
ZSYM_DEP_LIBS = -lcrypto
OABELIB = libopenabe.a

AR = ar
MAKE = make
ifndef BISON
BISON = ${ZROOT}/src/bin/bison
endif
FLEX = flex
INSTALL = install
