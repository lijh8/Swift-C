public struct helloLib {
    public private(set) var text = "Hello, World!"

    public init() {
        print(#fileID, #line, "")
    }
}
