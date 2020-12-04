import Foundation
import Glibc  // system library
import clib  // user library

// you can also import Glibc for fputs(3)
// then no need to mention: header "/.../stdio.h", link "c", in *.modulemap

var buf = [CChar](repeating: 0, count: 1024)
fputs("Your input: ", stdout)  // system function
fgets(&buf, Int32(buf.count), stdin)
print(String(cString: buf))

hello()  // user function
