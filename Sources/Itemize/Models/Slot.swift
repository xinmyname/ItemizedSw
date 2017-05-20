public class Slot:CustomStringConvertible {

    public var quantity:Int = 0
    public var item:Item?

    init(item:Item) {
        self.quantity = 1
        self.item = item
    }

	public var description:String {

        guard let item = self.item else {
            return ""
        }

        var quantityText = ""
        let text = self.quantity == 1
            ? "\(item)"
            : "\(item)s"

        switch (self.quantity) {
            case 1: quantityText = "An"
            case 0: quantityText = "No"
            case 2: quantityText = "Two"
            case 3: quantityText = "Three"
            case 4: quantityText = "Four"
            case 5: quantityText = "Five"
            case 6: quantityText = "Six"
            case 7: quantityText = "Seven"
            case 8: quantityText = "Eight"
            case 9: quantityText = "Nine"
            default: quantityText = "\(self.quantity)"
        }

        return "\(quantityText) \(text)"
	}

}