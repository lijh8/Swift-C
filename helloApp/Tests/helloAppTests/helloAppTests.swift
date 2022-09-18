import XCTest
@testable import helloApp

final class helloAppTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(helloApp().text, "Hello, World!")
    }
}
