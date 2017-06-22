import XCTest
@testable import Itemize

class GivenAPluralizer: XCTestCase {

	func testThatThePluralOfCatIsCats() {
		XCTAssertEqual("cat".pluralize(), "cats")
	}
}
