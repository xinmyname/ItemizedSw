import Foundation

public struct Descriptor:CustomStringConvertible,Hashable {
    
    private var _contents:[Int]
    
    var count:Int {
        get { return _contents.count }
    }
    
    init() {
        _contents = []
    }

    init(string:String) {
        _contents = string.components(separatedBy: "-").map { Int($0)! }
    }
    
    init(array:[Int]) {
        _contents = array
    }
    
    subscript(index:Int) -> Int {
        return _contents[index]
    }
    
    public var description: String {
        return _contents.map{String($0)}.joined(separator:"-")
    }
    
    var iterator: DescriptorIterator {
        return DescriptorIterator(_contents.makeIterator())
    }
    
    mutating func append(value:Int) {
        _contents.append(value)
    }

    mutating func append(index:Int?) {
        if let index = index {
            _contents.append(index+1)
        } else {
            _contents.append(0)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        
        for index in self._contents {
            hasher.combine(index)
        }
    }
}

class DescriptorIterator {
    
    enum NoMoreItems:Error { case error }
    enum InvalidLootKind:Error { case error }
    
    private var _it:IndexingIterator<[Int]>
    
    init(_ it:IndexingIterator<[Int]>) {
        _it = it
    }
    
    func next() throws -> Int {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return value
    }
    
    func nextIndex() throws -> Int {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return value-1
    }

    func nextKind() throws -> Item.Kind {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        guard let kind = Item.Kind(rawValue: value) else {
            throw InvalidLootKind.error
        }
        
        return kind
    }
    
    func nextItem(_ items:[String]) throws -> String {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        return items[value-1]
    }

    func nextOptionalItem(_ items:[String]) throws -> String {
        
        guard let value = _it.next() else {
            throw NoMoreItems.error
        }
        
        if value == 0 {
            return "?"
        }
        
        return items[value-1]
    }
}
