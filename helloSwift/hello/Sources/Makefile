# Makefile for top dir

# $(call makever,1.2.3)
# major.minor.patch
# libtool manual: -version-number
define makever
	@ $(MAKE) -C $@ soname=$(1)

	@ cp $(OBJDIR)/$@/$@ $(OBJDIR)/$@/lib$@.$(1).dylib

	@ ( cd $(OBJDIR)/$@ ; \
		ln -f -s lib$@.$(1).dylib lib$@.$(word 1,$(subst ., ,$(1))).dylib )

	@ ( cd $(OBJDIR)/$@ ; \
		ln -f -s lib$@.$(1).dylib lib$@.dylib )
endef

# make # BUILD_DIR=build
ifdef BUILD_DIR
export OBJDIR = $(abspath $(BUILD_DIR))
else
export OBJDIR = $(abspath build)
endif

SUBDIRS = bar # main

all : $(SUBDIRS)
install : $(SUBDIRS)
$(SUBDIRS) : | $(OBJDIR)
$(OBJDIR) : ; @ mkdir $@

# main : bar
# main : ; @ $(MAKE) -C $@
bar : ; $(call makever,1.2.3)

# make DESTDIR=~/bar install
# Alexandre Duret-Lutz's Autotools Tutorial (without animations):
# "is ready to be uncompressed in / on many hosts"
install :
	install -d $(DESTDIR)/usr/local/bin
	install -d $(DESTDIR)/usr/local/lib
	install -m 0755 $(OBJDIR)/main/main $(DESTDIR)/usr/local/bin
	cp -P $(OBJDIR)/bar/*.dylib* $(DESTDIR)/usr/local/lib

clean :
	@ for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
	-rm -fr $(OBJDIR)

.PHONY : $(SUBDIRS) all install clean
