import XCTest
@testable import ItemizeCore

class GivenAnEmptyDescriptor: XCTestCase {
    
    func testThatTheDescriptionIsEmpty() {
        let it = Descriptor()
        XCTAssertTrue(it.description.isEmpty)
    }
    
}

