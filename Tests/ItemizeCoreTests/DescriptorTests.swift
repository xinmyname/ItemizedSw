import XCTest
@testable import ItemizeCore

class DescriptorInitializerTests: XCTestCase {
    
    func testThatADescriptorIsMadeGivenNothing() {
        let d = Descriptor()
        XCTAssertTrue(d.description.isEmpty)
    }
    
    func testThatADescriptorIsMadeGivenSingleIndexAsAString() {
        let d = Descriptor(string: "1")
        XCTAssertEqual(d.description, "1")
    }
    
    func testThatADescriptorIsMadeGivenTwoIndicesAsAString() {
        let d = Descriptor(string: "1-2")
        XCTAssertEqual(d.description, "1-2")
    }
    
    func testThatADescriptorIsMadeGivenOneIndexAndOneNilIndexAsAString() {
        let d = Descriptor(string: "1-0")
        XCTAssertEqual(d.description, "1-0")
    }
    
    func testThatADescriptorIsMadeGivenSingleIndexAsAnArray() {
        let d = Descriptor(array: [1])
        XCTAssertEqual(d.description, "1")
    }
    
    func testThatADescriptorIsMadeGivenTwoIndicesAsAnArray() {
        let d = Descriptor(array: [1,2])
        XCTAssertEqual(d.description, "1-2")
    }
    
    func testThatADescriptorIsMadeGivenOneIndexAndOneNilIndexAsAnArray() {
        let d = Descriptor(array: [1,0])
        XCTAssertEqual(d.description, "1-0")
    }
}

class GivenAnEmptyDescriptor: XCTestCase {
    
    func testThatAnIndexIsAppended() {
        var d = Descriptor()
        d.append(index: 0)
        XCTAssertEqual(d.description, "0")
    }
    
    func testThatANilIndexIsAppended() {
        var d = Descriptor()
        d.append(index: nil)
        XCTAssertEqual(d.description, "?")
    }
}

class GivenADescriptorWithANilIndex : XCTestCase {
    
    func testThatTheIndexIsNil() {
        let d = Descriptor(string: "?")
        let it = d.iterator
        do {
            let index:Int? = try it.next()
            XCTAssertNil(index)
        }
        catch {
            XCTFail()
        }
    }
}

class GivenADescriptorWithTwoIndices: XCTestCase {
    
    func testThatAnIndexIsAppended() {
        var d = Descriptor(string: "1-2")
        d.append(index: 3)
        XCTAssertEqual(d.description, "1-2-3")
    }
    
    func testThatANilIndexIsAppended() {
        var d = Descriptor(string: "1-2")
        d.append(index: nil)
        XCTAssertEqual(d.description, "1-2-0")
    }
    
    func testThatAnIteratorContainsTwoItems() {
        let d = Descriptor(string: "1-2")
        let it = d.iterator
        XCTAssertNoThrow(try it.next())
        XCTAssertNoThrow(try it.next())
    }
    
    func testThatAnIteratorDoesNotContainThreeItems() {
        let d = Descriptor(string: "1-2")
        let it = d.iterator
        XCTAssertNoThrow(try it.next())
        XCTAssertNoThrow(try it.next())
        XCTAssertThrowsError(try it.next())
    }
}

class GivenTwoDescriptorsWithTheSameIndices: XCTestCase {
    
    func testThatTheyAreEqual() {
        let d1 = Descriptor(string: "1-?-3")
        let d2 = Descriptor(array: [1,-1,3])
        XCTAssertEqual(d1, d2)
    }
}

class GivenTwoDescriptorsWithDifferentIndices: XCTestCase {
    
    func testThatTheyAreNotEqual() {
        let d1 = Descriptor(string: "1-?")
        let d2 = Descriptor(array: [2,1])
        XCTAssertNotEqual(d1, d2)
    }
}

class GivenTwoDescriptorsWithDifferentLengths: XCTestCase {
    
    func testThatTheyAreNotEqual() {
        let d1 = Descriptor(string: "1-?-3-4-5")
        let d2 = Descriptor(array: [1,-1,3])
        XCTAssertNotEqual(d1, d2)
    }
}


