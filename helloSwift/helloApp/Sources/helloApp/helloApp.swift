import helloLib2 //module inside same package
import helloLib  //module from other package
import soLib     //so library in C language

@main
public struct helloApp {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(#fileID, #line, helloApp().text)

        var a = helloLib3() //file inside same module
        var b = helloLib2() //module inside same package
        var c = helloLib()  //module from other package
        hello()             //so library in C language
    }
}
