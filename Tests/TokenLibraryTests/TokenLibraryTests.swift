@testable import TokenLibrary
import XCTest

final class TokenLibraryTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TokenLibrary().text, "Hello, World!")
    }

    func testGetAuthCode() throws {
        let expectation = self.expectation(description: "Your expectation")

        TokenLibrary().getAuthToken { result, error in
            XCTAssertNotNil(result?.access_token)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 20)
    }
}
