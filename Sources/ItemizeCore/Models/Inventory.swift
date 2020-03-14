public class Inventory {
    
    private var _slots = [Descriptor:Slot]()

    public init() {
        
    }

    public func add(item:Item) {
        
        let descriptor = item.descriptor

        if _slots.keys.contains(descriptor) {

            if let slot = _slots[descriptor] {
                slot.quantity += 1
            }

        } else {
            _slots[descriptor] = Slot(item:item)
        }
    }

    public var slots:[Slot] {
        return [Slot](_slots.values)
    }
}
