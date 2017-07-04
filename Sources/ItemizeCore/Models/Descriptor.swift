public class Descriptor:CustomStringConvertible,Hashable {
    
    private var _contents:[Int]
    
    public init() {
        _contents = []
    }
    
    public init(string:String) {
        _contents = string.components(separatedBy: "-").map { $0 == "?" ? -1 : Int($0)! }
    }
    
    public init(array:[Int]) {
        _contents = array
    }
    
    public var description: String {
        return _contents
            .map { $0 < 0 ? "?" : String($0) }
            .joined(separator:"-")
    }
    
    public func append(index:Int?) {
        
        if let index = index {
            _contents.append(index)
        } else {
            _contents.append(-1)
        }
    }
    
    public var count: Int {
        return _contents.count
    }
    
    public subscript(position:Int) -> Int? {
        let index = _contents[position]
        return index < 0
            ? nil
            : index
    }
    
    public var iterator: DescriptorIterator {
        return DescriptorIterator(self)
    }
    
    public var hashValue:Int {
        var result = 0
        
        for index in _contents {
            result = (result * 397) ^ index
        }
        
        return result
    }
    
    public static func ==(lhs: Descriptor, rhs: Descriptor) -> Bool {

        if lhs.count != rhs.count {
            return false
        }
        
        for i in 0..<lhs.count {
            if lhs[i] != rhs[i] {
                return false
            }
        }
        
        return true
    }
}

public class DescriptorIterator {
    
    enum ReferenceLost:Error { case error }
    enum NoMoreItems:Error { case error }
    
    private weak var _descriptor:Descriptor?
    private var _position = 0
    
    public init(_ descriptor:Descriptor) {
        _descriptor = descriptor
    }
    
    public func next() throws -> Int? {
        
        guard let descriptor = _descriptor else {
            throw ReferenceLost.error
        }
        
        if _position >= descriptor.count {
            throw NoMoreItems.error
        }
        
        let index:Int? = descriptor[_position]
        
        _position += 1
        
        return index
    }
}


