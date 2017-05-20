import Darwin

var count:Int = 1

if CommandLine.arguments.count > 1 {

    let arg:String = CommandLine.arguments[1]

    if arg == "-h" || arg == "--help" {
        print("Usage: Itemize <count>")
        exit(1)
    }

    if let argCount:Int = Int(arg) {
        count = argCount
    }
    
}

let inventory = Inventory()
let itemFactory = ItemFactory()

while count > 0 {
    inventory.add(item:itemFactory.makeItem())
    count -= 1
}

print("You have: ")

for slot in inventory.slots {
    print("  \(slot)")
}
