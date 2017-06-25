public class Descriptor:Hashable {
    public static let `default` = Descriptor()

    public var hashValue:Int { 
        return 0
    }

    public static func ==(lhs: Descriptor, rhs: Descriptor) -> Bool {
        return true
    }

}
