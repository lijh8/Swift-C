# build shared library with -fPIC, -shared
CFLAGS   = -Wall -Wextra -g -fPIC # -O3 # CXXFLAGS for .cpp
CPPFLAGS = -MMD -MP # -I../foo
LDFLAGS  = -shared # -L../foo #
LDLIBS   = # -lfoo
#CC      = $(CXX) # link with CXX for .cpp
LDFLAGS += -dynamiclib -install_name @rpath/libfoo.dylib -current_version 1.2.3

# target name is basename of one of the source files
foo : $(patsubst %.c,%.o,$(wildcard *.c)) # .cpp
-include *.d
clean : ; -rm -fr *.o *.d
.PHONY : clean
