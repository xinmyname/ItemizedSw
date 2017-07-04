import XCTest
@testable import ItemizeCore

class GivenAPluralizer: XCTestCase {

	func testThatThePluralOfCatIsCats() {		
		XCTAssertEqual("cat".pluralize(), "cats")
	}
}