public class Slot:CustomStringConvertible {

    public var quantity:Int = 0
    public var item:Item?

    init(item:Item) {
        self.quantity = 1
        self.item = item
    }

	public var description:String {

        guard let item = self.item else {
            return "Nothing"
        }
        
        var found = false
        var text = "\(item)"
        
        while !found {
            
            if let optionalRange:Range<String.Index> = text.range(of: "?") {
                
                text.remove(at: optionalRange.lowerBound)
                text.remove(at: optionalRange.lowerBound)
                
            } else {
                found = true
            }
        }
        
        if let pluralRange = text.range(of: "^") {
            
            let startIndex = pluralRange.lowerBound
            
            if self.quantity == 1 {
                
                text.remove(at: startIndex)
                
                let quantityText = text.starts(withAny: Slot.VowelPrefixes)
                    ? "An"
                    : "A"
                
                return "\(quantityText) \(text)"
            }
            
            var singular = String(text[pluralRange.upperBound...]) //text.substring(from: pluralRange.upperBound)
            
            if let spaceRange = singular.range(of: " ") {
                singular = String(singular[..<spaceRange.lowerBound]) //singular.substring(to: spaceRange.lowerBound)
            }
            
            let plural = singular.pluralize()
            
            let distance = singular.distance(from: singular.startIndex, to: singular.endIndex)
            let endIndex = text.index(startIndex, offsetBy: distance+1)
            
            text = text.replacingCharacters(in: startIndex..<endIndex, with: plural)
            
            var quantityText = ""
            
            switch self.quantity {
            case 2: quantityText = "Two"
            case 3: quantityText = "Three"
            case 4: quantityText = "Four"
            case 5: quantityText = "Five"
            case 6: quantityText = "Six"
            case 7: quantityText = "Seven"
            case 8: quantityText = "Eight"
            case 9: quantityText = "Nine"
            default:
                quantityText = String(self.quantity)
            }
            
            text = "\(quantityText) \(text)"
            
        } else {
            let firstLetter = text.first!
            let capitalLetter = String(firstLetter).capitalized
            text.remove(at: text.startIndex)
            text.insert(capitalLetter.first!, at: text.startIndex)
        }
        
        return text
	}
    
    private static let VowelPrefixes = [
        "alum",
        "aqua",
        "azur",
        "ecru",
        "eggs",
        "Elve",
        "emer",
        "endu",
        "extr",
        "inca",
        "indi",
        "irid",
        "iron",
        "onyx",
        "opal",
        "Orci",
        "osmi",
        "Unde"
    ]
}
