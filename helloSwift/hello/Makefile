# Makefile for top dir

# $(call makever,1.2.3)
# major.minor.patch
# libtool manual: -version-number
define makever
	@ $(MAKE) -C $@ soname=lib$@.so.$(word 1,$(subst ., ,$(1)))

	@ cp $(OBJDIR)/$@/$@ $(OBJDIR)/$@/lib$@.so.$(1)

	@ cd $(OBJDIR)/$@ ; \
		ln -f -s lib$@.so.$(1) lib$@.so.$(word 1,$(subst ., ,$(1))) ; \
		cd - >/dev/null 2>&1 ;

	@ cd $(OBJDIR)/$@ ; \
		ln -f -s lib$@.so.$(1) lib$@.so ; \
		cd - >/dev/null 2>&1 ;
endef

# make # BUILD_DIR=build
ifdef BUILD_DIR
export OBJDIR = $(abspath $(BUILD_DIR))
else
export OBJDIR = $(abspath build)
endif

SUBDIRS = main foo

all : $(SUBDIRS)
install : $(SUBDIRS)
$(SUBDIRS) : | $(OBJDIR)
$(OBJDIR) : ; @ mkdir $@

main : foo
main : ; @ $(MAKE) -C $@
foo : ; $(call makever,1.2.3)

# make DESTDIR=~/foo install
# Alexandre Duret-Lutz's Autotools Tutorial (without animations):
# "is ready to be uncompressed in / on many hosts"
install :
	install -d $(DESTDIR)/usr/local/bin
	install -d $(DESTDIR)/usr/local/lib
	install -m 0755 $(OBJDIR)/main/main $(DESTDIR)/usr/local/bin
	cp -P $(OBJDIR)/foo/*.so* $(DESTDIR)/usr/local/lib

clean :
	@ for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
	-rm -fr $(OBJDIR)

.PHONY : $(SUBDIRS) all install clean
