import Foundation
import XCTest
import DorinikusSDK

final class PersonTests: XCTestCase {
    func testPerson() {
        XCTAssertThrowsError(try Person(firstName: "",
                                        lastName: ""))
        
        XCTAssertThrowsError(try Person(firstName: "Felix",
                                        lastName: ""))
        
        XCTAssertThrowsError(try Person(firstName: "",
                                        lastName: "Deimel"))
    }
}
