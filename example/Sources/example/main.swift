import clib

// you can also use Glibc for fputs(3)
// then no need to mention: header "/.../stdio.h", link "c", in *.modulemap
//import Glibc

hello()
fputs("Swift calls fputs(3)\n", stdout)
