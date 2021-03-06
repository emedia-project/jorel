# Configuration

JOREL_CONFIG ?= jorel.config
JOREL_BUILD ?= false

ifndef (JOREL)
ifeq ($(JOREL_MASTER),true)
JOREL_EXE = jorel.master
else
JOREL_EXE = jorel
endif

JOREL_URL ?= https://github.com/G-Corp/jorel/wiki/$(JOREL_EXE)
JOREL_MD5_URL = $(JOREL_URL).md5

ifeq ($(JOREL_BUILD),true)
JOREL ?= $(DEPS_DIR)/jorel/jorel
else
JOREL ?= $(HOME)/.jorel/$(JOREL_EXE)
RMD5 = $(shell curl -s -L ${JOREL_MD5_URL} | cut -f 1 -d " ")
LMD5 = $(shell md5sum ${JOREL} | cut -f 1 -d " ")
endif
else
RMD5=1
LMD5=$(RMD5)
endif

export JOREL

help::
	$(verbose) printf "%s\n" "" \
		"Jorel targets:" \
		"  jorel.release        Create a release with Jorel" \
		"  jorel.appup          Create appup" \
		"  jorel.relup          Create relup for release" \
		"  jorel.archive        Create archive release" \
		"  jorel.exec cmd=CMD   Execute the Jorel command specified" \
	  "" \
		"Jorel rules accepts the following options :" \
		" * o=OUTPUT_DIR" \
		" * n=REL_NAME" \
		" * v=REL_VERSION" \
		" * c=CONFIG_FILE"

jorel.release:
	$(verbose) make jorel.exec cmd=release

jorel.appup:
	$(verbose) make jorel.exec cmd=appup

jorel.relup:
	$(verbose) make jorel.exec cmd=relup

jorel.archive:
	$(verbose) make jorel.exec cmd=archive

$(JOREL_CONFIG):
	$(verbose) make jorel.exec cmd=gen_config

ifeq ($(cmd),gen_config)
jorel.exec: jorel.run
else
jorel.exec: $(JOREL_CONFIG) jorel.run
endif

jorel.run: app $(JOREL)
ifndef cmd
	$(error Usage: $(MAKE) jorel.exec cmd=CMD)
endif
	$(eval x := )
ifdef o
	$(eval x := --output-dir $o $x)
endif
ifdef n
	$(eval x := --relname $n $x)
endif
ifdef v
	$(eval x := --relvsn $v $x)
endif
ifdef c
	$(eval x := --config $c $x)
endif
	$(verbose) $(JOREL) $(cmd) $x

ifeq ($(JOREL_BUILD),true)
$(JOREL): rel-deps
else
ifeq ($(RMD5),$(LMD5))
$(JOREL):
else
$(JOREL):
	$(verbose) curl -L $(JOREL_MD5_URL)
	$(verbose) mkdir -p $(dir $(JOREL))
	$(gen_verbose) $(call core_http_get,$(JOREL),$(JOREL_URL))
	$(verbose) chmod +x $(JOREL)
endif
endif

