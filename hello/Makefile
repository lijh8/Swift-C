# build shared library with -fPIC, -shared
CFLAGS   = -g -fPIC # CXXFLAGS
LDFLAGS  = -shared #-L../hello
LDLIBS   = # -lpthread
CPPFLAGS = -MMD -MP # -DNDEBUG # -I../hello
#CC      = $(CXX)  # change linker for .cpp

# target should be basename of one source file
hello : $(patsubst %.c,%.o,$(wildcard *.c))  # .cpp
-include *.d
clean : ; -rm -fr *.o *.d
.PHONY : clean
