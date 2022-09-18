import Foundation
import helloLib
import soLib

print(#fileID, #line, "")
let a = helloLib()  // swift library
hello()             // C library with so
