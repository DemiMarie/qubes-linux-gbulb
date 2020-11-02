RPM_SPEC_FILES := python3-gbulb.spec
NO_ARCHIVE := 1
DEBIAN_BUILD_DIRS = debian-pkg/debian

ifneq ($(filter $(DISTRIBUTION), debian),)
SOURCE_COPY_IN := source-debian-copy-in
endif

source-debian-copy-in: VERSION = $(shell cat $(ORIG_SRC)/version)
source-debian-copy-in: ORIG_FILE = $(CHROOT_DIR)/$(DIST_SRC)/python3-gbulb_$(VERSION).orig.tar.gz
source-debian-copy-in: SRC_FILE  = $(ORIG_SRC)/gbulb-$(VERSION).tar.gz
source-debian-copy-in:
	cp -p $(SRC_FILE) $(ORIG_FILE)
	$(shell $(ORIG_SRC)/debian-quilt $(ORIG_SRC)/series-debian.conf $(CHROOT_DIR)/$(DIST_SRC)/debian/patches)
	tar xzf $(SRC_FILE) -C $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg --strip-components=1
