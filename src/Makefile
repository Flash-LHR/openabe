include Makefile.inc
include ../Makefile.common

.PHONY: all clean header

CC ?= gcc

OABE_INCLUDE_DIR := $(INCLUDE_ROOT)/openabe
CXX11FLAGS += $(CXXFLAGS)

RELICLIBS = -lrelic_s 
#$(DEPS_INSTALL_ROOT)/lib/librelic_s.a

OABE_SHLIB = libopenabe.$(SHLIB)
OABE_KEYS = keys/zkdf.o keys/zkey.o keys/zpkey.o keys/zkeystore.o keys/zsymkey.o
OABE_LOW = ske/zcontextske.o pke/zcontextpke.o pksig/zcontextpksig.o \
          abe/zcontextabe.o abe/zcontextcca.o abe/zcontextcpwaters.o abe/zcontextkpgpsw.o
OABE_TOOLS = tools/zlsss.o tools/zprng.o 
OABE_ZML = zml/zgroup.o zml/zpairing.o zml/zelliptic.o zml/zelement.o zml/zelement_ec.o zml/zelement_bp.o
OABE_UTILS = utils/zkeymgr.o utils/zcryptoutils.o utils/zcontainer.o utils/zbenchmark.o utils/zerror.o utils/zcontainer.o \
            utils/zciphertext.o utils/zpolicy.o utils/zattributelist.o utils/zdriver.o utils/zfunctioninput.o
            
OABE_OBJ_TARGETS = zobject.o openabe.o zcontext.o zcrypto_box.o zsymcrypto.o zparser.o zscanner.o \
                  $(OABE_ZML) $(OABE_KEYS) $(OABE_LOW) $(OABE_TOOLS) $(OABE_UTILS) openssl_init.o $(OS_OBJS)

OABE_OBJ_FILES = zobject.o openabe.o zgroup.o zlsss.o zerror.o zpairing.o zelliptic.o zelement.o zelement_ec.o zelement_bp.o zcontainer.o zciphertext.o \
	     zkey.o zpkey.o zkeystore.o zfunctioninput.o zcontext.o zpolicy.o zsymkey.o zprng.o zattributelist.o \
	     zcontextske.o zcontextpke.o zcontextpksig.o zcontextabe.o zcontextcpwaters.o zcontextkpgpsw.o \
	     zcontextcca.o zkdf.o zkeymgr.o zcryptoutils.o zcrypto_box.o zbenchmark.o zparser.o zscanner.o zdriver.o zsymcrypto.o \
	     openssl_init.o $(OS_OBJS)
	     
ifeq ($(OS),Windows_NT)
    LDFLAGS += -L/mingw64/bin
endif

ifeq ($(ENABLE_GCOV), yes)
  CXXFLAGS += $(COVERAGE_CFLAGS)
  LDFLAGS += $(COVERAGE_LINKER)
  SHFLAGS += $(COVERAGE_LINKER)
endif

ifeq ($(OS_FAMILY), redhat)
    BISON_PARSER_DEF="parser_class_name=Parser"
else
    BISON_PARSER_DEF="api.parser.class=Parser"
endif

ZSYM_OBJS = zobject.o zerror.o zprng.o zsymcrypto.o

LIBRARYH=header

GENFILES = location.hh position.hh stack.hh *.tab.* zscanner.cpp

all: $(OABELIB) $(ZSYMLIB)

zml/zelement.o:
	$(CC) $(CCFLAGS) -c zml/zelement.c -o zelement.o

zparser.o: zparser.yy
	$(BISON) -d -D $(BISON_PARSER_DEF) -v zparser.yy
	cp *.hh $(OABE_INCLUDE_DIR)
	$(CXX) $(CXXFLAGS) -c -o zparser.o zparser.tab.cc

zscanner.o: zscanner.ll
	$(FLEX) --outfile=zscanner.cpp  $<
	$(CXX) $(CXXFLAGS) -c zscanner.cpp -o zscanner.o

header:
	mkdir -p $(OABE_INCLUDE_DIR)
	cp -r include/openabe/* $(OABE_INCLUDE_DIR)
	
# provides PK, ABE, AEAD and crypto tools 
$(OABELIB): $(LIBRARYH) $(OABE_OBJ_TARGETS)
	$(AR) rcs $@ $(OABE_OBJ_FILES)
	$(CXX) $(SHFLAGS) -o $(OABE_SHLIB) $(OABE_OBJ_FILES) $(SHLIB_PATH) $(OABELDSHLIBS)
	mkdir -p $(OABE_LIB_ROOT)
	cp $@ $(OABE_LIB_ROOT)
	cp $(OABE_SHLIB) $(OABE_LIB_ROOT)

# provides only AEAD impl for integration with libzclient
$(ZSYMLIB): $(OABELIB)
	$(AR) rcs $(ZSYMLIB) $(ZSYM_OBJS)
	cp $@ $(OABE_LIB_ROOT)


clean:
	-rm -rf *.o *.dSYM a.out zparser.output $(PROGRAMS) $(OABELIB) $(OABE_SHLIB) $(ZSYMLIB) $(GENFILES)
	-rm -f librelic*.$(SHLIB) libcrypto.$(SHLIB) libsl.$(SHLIB)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

%.o: %.c
	$(CC) $(CXXFLAGS) -c $<
