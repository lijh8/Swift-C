import bar // so library in C language, module.modulemap: bar
import foo // another package
import hello3_dir // a module in same package

@main
public struct hello {
    public static func main() {
        print("hello")

        foo() // another package, requires public

        // a module is a subdir under "Sources" dir: "Sources/hello"
        hello2() // a file in same module, no need to import

        hello3() // another module, requires public

        //bar: c so library
        let n = 1024
        var s1 = [CChar](repeating: 0, count: n)
        let s2 = "hello"
        strncpy2(&s1, s2, s1.count) // function in so library
        print("so", String(cString: s1))

        var n1: CInt = 0
        let n2: CInt = 123
        intcpy(&n1, n2) // function in so library
        print("so", n1)
    }
}
