import Foundation

public class Item:CustomStringConvertible {

    public var descriptor: Descriptor
    
    public init() {
        let kind = Kind.oneAtRandom()
        self.descriptor = Descriptor(array: [kind.rawValue])
        
        switch kind {
        case .weapon: self.makeWeapon()
/*
        case .armor: self.makeArmor()
        case .monsterPart: self.makeMonsterPart()
        case .tool: self.makeTool()
        case .scroll: self.makeScroll()
        case .wand: self.makeWand()
        case .potion: self.makePotion()
        case .amulet: self.makeAmulet()
        case .ring: self.makeRing()
        case .bracelet: self.makeBracelet()
        case .necklace: self.makeNecklace()
        case .staff: self.makeStaff()
        case .key: self.makeKey()
        case .ammunition: self.makeAmmunition()
        case .gemstone: self.makeGemstone()
        case .ore: self.makeOre()
        case .clothes: self.makeClothes()
        case .book: self.makeBook()
        case .utensil: self.makeUtensil()
*/
        }
    }
    
    public var description: String {
        let it = self.descriptor.iterator
        
        do {
            let kind = try it.nextKind()

            switch kind {
            case .weapon: return try self.describeWeapon(iterator:it)
/*
            case .armor: return try self.describeArmor(iterator:it)
            case .monsterPart: return try self.describeMonsterPart(iterator:it)
            case .tool: return try self.describeTool(iterator:it)
            case .scroll: return try self.describeScroll(iterator:it)
            case .wand: return try self.describeWand(iterator:it)
            case .potion: return try self.describePotion(iterator:it)
            case .amulet: return try self.describeAmulet(iterator:it)
            case .ring: return try self.describeRing(iterator:it)
            case .bracelet: return try self.describeBracelet(iterator:it)
            case .necklace: return try self.describeNecklace(iterator:it)
            case .staff: return try self.describeStaff(iterator:it)
            case .key: return try self.describeKey(iterator:it)
            case .ammunition: return try self.describeAmmunition(iterator:it)
            case .gemstone: return try self.describeGemstone(iterator:it)
            case .ore: return try self.describeOre(iterator:it)
            case .clothes: return try self.describeClothes(iterator:it)
            case .book: return try self.describeBook(iterator:it)
            case .utensil: return try self.describeUtensil(iterator:it)
*/
            }
        }
        catch {
            return "(error: \(error.localizedDescription))"
        }
    }

    private func makeWeapon() {
        
        let style = Int(arc4random_uniform(2))
        
        self.descriptor.append(value: style)

        self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
        
        switch style {
        
        case 0: self.descriptor.append(index: Item.Races.oneIndexAtRandom(nilStrategy: .equalChance))
        
        case 1: self.descriptor.append(index: Item.Materials.oneIndexAtRandom(nilStrategy: .equalChance))
        
        default:break
        
        }
        
        self.descriptor.append(index: Item.Weapons.oneIndexAtRandom())
    }

    private func describeWeapon(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        
        switch style {
        
        case 0:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let race = try iterator.nextOptionalItem(Item.Races)
            let weapon = try iterator.nextItem(Item.Weapons)
            return "\(weight) \(race) \(weapon)"
            
        case 1:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let material = try iterator.nextOptionalItem(Item.Materials)
            let weapon = try iterator.nextItem(Item.Weapons)
            return "\(weight) \(material) \(weapon)"
        
        default:
            return ""
        }
    
    }

    
    
    

    private static let Weapons = [
        "^dagger",
        "^knife",
        "^axe",
        "short ^sword",
        "^broadsword",
        "long ^sword",
        "^katana",
        "^saber",
        "^club",
        "^mace",
        "morning ^star",
        "^flail",
        "^quarterstaff",
        "^polearm",
        "^spear",
        "^bow",
        "^crossbow"
    ]
    
    private static let Armors = [
        "armor ^set",
        "gauntlets",
        "^helm",
        "boots"
    ]
    
    private static let MonsterParts = [
        "^hide",
        "^fur",
        "^tusk",
        "^horn",
        "^tooth",
        "^bone"
    ]
    
    private static let Tools = [
        "^saw",
        "^axe",
        "scissors",
        "^hammer",
        "^wrench",
        "pliers"
    ]
    
    private static let Clothes = [
        "^shirt",
        "trousers",
        "shorts",
        "capris",
        "^skirt",
        "^robe",
        "^hood",
        "^glove",
        "^dress",
        "^jacket",
        "^vest",
        "pajamas",
        "^scarf",
        "^coat",
        "^cap",
        "^cape",
        "^mask",
        "^headband"
    ]
    
    private static let Utensils = [
        "^fork",
        "^spoon",
        "^knife"
    ]
    
    private static let Races = [
        "Elven",
        "Orcish",
        "Dwarven",
        "Gnomish",
        "Demonic",
        "Undead"
    ]
    
    private static let Aspects = [
        "shimmering",
        "sparkling",
        "glittering",
        "incandescent",
        "glowing",
        "dirty",
        "dingy",
        "shabby",
        "faded",
        "bright",
        "flawless",
        "translucent",
        "cloudy"
    ]
    
    private static let Characteristics = [
        "healing",
        "pain",
        "agony",
        "hunger",
        "strength",
        "agility",
        "stamina",
        "intellect",
        "teleportation",
        "protection",
        "invisibility",
        "speed",
        "slowness",
        "heaviness",
        "lightness",
        "blundering",
        "clumsiness",
        "dexterity",
        "sleepiness",
        "hate",
        "amore",
        "vigor",
        "itching",
        "accuracy",
        "cowardice",
        "inebriation",
        "sobriety",
        "endurance",
        "persuasion",
        "polymorphism",
        "blindness"
    ]
    
    private static let Gems = [
        "ruby",
        "diamond",
        "quartz",
        "emerald",
        "jade",
        "opal",
        "onyx",
        "pearl",
        "sapphire",
        "topaz",
        "turquoise",
        "cubit zirconia"
    ]
    
    private static let Lengths = [
        "short",
        "medium",
        "long"
    ]
    
    private static let Sizes = [
        "very small",
        "small",
        "medium",
        "large",
        "extra large",
        "extremely large"
    ]
    
    private static let Weights = [
        "weightless",
        "very light",
        "light",
        "heavy",
        "very heavy",
        "extremely heavy"
    ]
    
    public static let Colors = [
        "white",
        "azure",
        "blue",
        "aquamarine",
        "crimson",
        "red",
        "brown",
        "golden",
        "green",
        "gray",
        "lavendar",
        "pink",
        "indigo",
        "green",
        "cream",
        "eggshell",
        "beige",
        "ecru",
        "turquoise",
        "tan",
        "teal",
        "yellow",
        "purple",
        "magenta",
        "cornflower blue"
    ]
    
    private static let MetalElements = [
        "aluminum",
        "titanium",
        "vanadium",
        "chromium",
        "manganese",
        "iron",
        "cobalt",
        "nickel",
        "copper",
        "zinc",
        "gallium",
        "yttrium",
        "zirconium",
        "niobium",
        "molybdenum",
        "ruthenium",
        "rhodium",
        "palladium",
        "silver",
        "cadmium",
        "indium",
        "tin",
        "hafnium",
        "tantalum",
        "tungsten",
        "rhenium",
        "osmium",
        "iridium",
        "platinum",
        "gold",
        "thallium",
        "lead",
        "bismuth",
        "polonium",
        "thorium",
        "uranium",
        "plutonium"
    ]
    
    private static let Metals = [
        "aluminum",
        "titanium",
        "iron",
        "cast iron",
        "silver",
        "gold",
        "rose gold",
        "white gold",
        "platinum",
        "copper",
        "steel",
        "brass",
        "nickel",
        "zinc",
        "tungsten",
        "palladium",
        "tin",
        "bronze",
        "pewter",
        "sterling silver"
    ]
    
    private static let Materials = [
        "wooden",
        "copper",
        "brass",
        "bronze",
        "silver",
        "gold",
        "quartz",
        "glass",
        "rubber",
        "bone"
    ]
    
    private static let Topics = [
        "Philosophy",
        "Metaphysics",
        "Magic",
        "Animals",
        "Plants",
        "Mushrooms",
        "Insects",
        "Machines",
        "Mathematics",
        "Statistics",
        "Logic",
        "Geology",
        "Astronomy",
        "Meteorology",
        "Alchemy",
        "History",
        "The Dead",
        "Business Administration",
        "Law",
        "Medicene",
        "Herbs",
        "Spices",
        "Herbs and Spices",
        "Illustrated Recipes",
        "Art",
        "Architecture",
        "Mystery",
        "Known Felons",
        "Known Time Travelers",
        "Kings",
        "Queens",
        "Gardening",
        "Engineering",
        "Monsters",
        "Wizardry"
    ]
    
    private static let Mails = [
        "fur",
        "leather",
        "bone",
        "scale mail",
        "plate mail",
        "chain mail",
        "banded mail"
    ]
        
    private static let Enchantments = [
        "blessed",
        "cursed"
    ]

    private static let Masses = [
        "^milligram",
        "^gram",
        "^kilogram"
    ]
    
    public enum Kind:Int {
        
        case weapon
/*
        case armor
        case monsterPart
        case tool
        case scroll
        case wand
        case potion
        case amulet
        case ring
        case bracelet
        case necklace
        case staff
        case key
        case ammunition
        case gemstone
        case ore
        case clothes
        case book
        case utensil
*/
        
        private static var _count:Int {
            get {
                var max:Int = 0
                while let _ = Kind(rawValue: max) {
                    max += 1
                }
                return max
            }
        }
        
        static func oneAtRandom() -> Kind {
            return Kind(rawValue: Int(arc4random_uniform(UInt32(_count))))!
        }
    }
}
