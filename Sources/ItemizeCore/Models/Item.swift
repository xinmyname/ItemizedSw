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

    private func makeArmor() {
        
        let style = Int(arc4random_uniform(2))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Races.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Mails.oneIndexAtRandom())
            self.descriptor.append(index: Item.Armors.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Races.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
            
        default:break
            
        }
    }

    private func describeArmor(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let aspect = try iterator.nextOptionalItem(Item.Aspects)
            let race = try iterator.nextOptionalItem(Item.Races)
            let mail = try iterator.nextItem(Item.Mails)
            let armor = try iterator.nextItem(Item.Armors)
            return "\(aspect) \(race) \(mail) \(armor)"
            
        case 1:
            let aspect = try iterator.nextOptionalItem(Item.Aspects)
            let race = try iterator.nextOptionalItem(Item.Races)
            let material = try iterator.nextItem(Item.Materials)
            return "\(aspect) \(race) \(material) ^shield"
            
        default:
            return ""
        }
    }
    
    private func makeMonsterPart() {
        
        self.descriptor.append(index: Item.Colors.oneIndexAtRandom())
        self.descriptor.append(index: Item.MonsterParts.oneIndexAtRandom())
    }
    
    private func describeMonsterPart(iterator:DescriptorIterator) throws -> String {
        
        let color = try iterator.nextItem(Item.Colors)
        let part = try iterator.nextItem(Item.MonsterParts)
        return "\(color) monster \(part)"
    }
    
    private func makeTool() {
        self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
        self.descriptor.append(index: Item.Tools.oneIndexAtRandom())
    }
    
    private func describeTool(iterator:DescriptorIterator) throws -> String {
        let weight = try iterator.nextOptionalItem(Item.Weights)
        let metal = try iterator.nextItem(Item.Metals)
        let tool = try iterator.nextItem(Item.Tools)
        return "\(weight) \(metal) \(tool)"
    }
    
    private func makeScroll() {
        self.descriptor.append(index: Item.Enchantments.oneIndexAtRandom(nilStrategy: .probability(value:0.80)))
        self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
    }
    
    private func describeScroll(iterator:DescriptorIterator) throws -> String {
        let enchantment = try iterator.nextOptionalItem(Item.Enchantments)
        let characteristic = try iterator.nextItem(Item.Characteristics)
        return "\(enchantment) ^scroll of \(characteristic)"
    }
    
    private func makeWand() {
        let style = Int(arc4random_uniform(2))
        
        self.descriptor.append(value: style)
        self.descriptor.append(index: Item.Enchantments.oneIndexAtRandom(nilStrategy: .probability(value:0.90)))

        switch style {
        
        case 0:
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
        case 1:
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
        default:
            break
        }

        self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
    }
    
    private func describeWand(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        let enchantment = try iterator.nextOptionalItem(Item.Enchantments)

        switch style {
        case 0:
            let material = try iterator.nextItem(Item.Materials)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(enchantment) \(material) ^wand of \(characteristic)"
        case 1:
            let metal = try iterator.nextItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(enchantment) \(metal) ^wand of \(characteristic)"
        default:
            return ""
        }
    }
    
    private func makePotion() {
        self.descriptor.append(index: Item.Colors.oneIndexAtRandom())
        self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
    }
    
    private func describePotion(iterator:DescriptorIterator) throws -> String {
        let color = try iterator.nextItem(Item.Colors)
        let characteristic = try iterator.nextItem(Item.Characteristics)
        return "\(color) ^potion of \(characteristic)"
    }
    
    private func makeAmulet() {
        
        let randomStyle = arc4random_uniform(4001)
        let style = (randomStyle != 4000)
            ? Int(randomStyle / 1000)
            : 4
        
        self.descriptor.append(value: style)
        
        switch style {

        case 0:
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
        
        case 1:
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
        
        case 2:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
        
        case 3:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
        default:
            break
        }
    }
    
    private func describeAmulet(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Item.Metals)
            return "\(metal) ^amulet"
            
        case 1:
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(metal) ^amulet of \(characteristic)"
            
        case 2:
            let gem = try iterator.nextItem(Item.Gems)
            return "\(gem) ^amulet"
            
        case 3:
            let gem = try iterator.nextItem(Item.Gems)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(gem) ^amulet of \(characteristic)"
            
        case 4:
            return "The Amulet of Yendor"
            
        default:
            return ""
            
        }
    }
    
    private func makeRing() {
        let style = Int(arc4random_uniform(6))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        case 2:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            
        case 3:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
           
        case 4:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 5:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
        
    }
    
    private func describeRing(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let metal = try iterator.nextItem(Item.Metals)
            return "\(metal) ^ring"
            
        case 1:
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(metal) ^ring of \(characteristic)"
            
        case 2:
            let gem = try iterator.nextItem(Item.Gems)
            return "\(gem) ^ring"
            
        case 3:
            let gem = try iterator.nextItem(Item.Gems)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(gem) ^ring of \(characteristic)"
            
        case 4:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextItem(Item.Metals)
            return "\(gem) encrusted \(metal) ^ring"

        case 5:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(gem) encrusted \(metal) ^ring of \(characteristic)"
            
        default:
            return ""
            
        }
    }
    
    private func makeBracelet() {
        let style = Int(arc4random_uniform(4))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        case 2:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 3:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeBracelet(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let metal = try iterator.nextItem(Item.Metals)
            return "\(weight) \(metal) ^bracelet"
            
        case 1:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(weight) \(metal) ^bracelet of \(characteristic)"
            
        case 2:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextItem(Item.Metals)
            return "\(gem) encrusted \(metal) ^bracelet"
            
        case 3:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(gem) encrusted \(metal) ^bracelet of \(characteristic)"

        default:
            return ""
            
        }
    }
    
    private func makeNecklace() {
        let style = Int(arc4random_uniform(4))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        case 2:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom())
            
        case 3:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Metals.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Characteristics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeNecklace(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let metal = try iterator.nextItem(Item.Metals)
            return "\(weight) \(metal) ^necklace"
            
        case 1:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(weight) \(metal) ^necklace of \(characteristic)"
            
        case 2:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextItem(Item.Metals)
            return "\(gem) encrusted \(metal) ^necklace"
            
        case 3:
            let gem = try iterator.nextItem(Item.Gems)
            let metal = try iterator.nextOptionalItem(Item.Metals)
            let characteristic = try iterator.nextItem(Item.Characteristics)
            return "\(gem) encrusted \(metal) ^necklace of \(characteristic)"
            
        default:
            return ""
            
        }
    }
    
    private func makeStaff() {
        let style = Int(arc4random_uniform(4))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
            
        case 2:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
            
        case 3:
            self.descriptor.append(index: Item.Gems.oneIndexAtRandom())
            self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeStaff(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let material = try iterator.nextItem(Item.Materials)
            return "\(material) ^rod"
            
        case 1:
            let material = try iterator.nextItem(Item.Materials)
            return "\(material) ^staff"
            
        case 2:
            let gem = try iterator.nextItem(Item.Gems)
            let material = try iterator.nextItem(Item.Materials)
            return "\(gem) encrusted \(material) ^rod"
            
        case 3:
            let gem = try iterator.nextItem(Item.Gems)
            let material = try iterator.nextItem(Item.Materials)
            return "\(gem) encrusted \(material) ^staff"
            
        default:
            return ""
            
        }
    }
    
    private func makeKey() {
        self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
        
    }
    
    private func describeKey(iterator:DescriptorIterator) throws -> String {
        let aspect = try iterator.nextOptionalItem(Item.Aspects)
        let material = try iterator.nextItem(Item.Materials)
        return "\(aspect) \(material) ^key"
    }
    
    private func makeAmmunition() {
        let style = Int(arc4random_uniform(4))
        
        self.descriptor.append(value: style)
        self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
    }
    
    private func describeAmmunition(iterator:DescriptorIterator) throws -> String {
        
        let style:Int = try iterator.next()
        let aspect = try iterator.nextOptionalItem(Item.Aspects)
        let material = try iterator.nextItem(Item.Materials)
        
        if style == 0 {
            return "\(aspect) \(material) ^arrow"
        }
        
        return "\(aspect) \(material) ^bolt"
    }
    
    private func makeGemstone() {

        self.descriptor.append(index: Item.Sizes.oneIndexAtRandom())
        self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Colors.oneIndexAtRandom())
    }
    
    private func describeGemstone(iterator:DescriptorIterator) throws -> String {

        let size = try iterator.nextItem(Item.Sizes)
        let aspect = try iterator.nextOptionalItem(Item.Aspects)
        let color = try iterator.nextItem(Item.Colors)
        return "\(size) \(aspect) \(color) ^gem"
    }
    
    private func makeOre() {
        self.descriptor.append(index: Item.Masses.oneIndexAtRandom())
        self.descriptor.append(index: Item.MetalElements.oneIndexAtRandom())
    }
    
    private func describeOre(iterator:DescriptorIterator) throws -> String {
        let mass = try iterator.nextItem(Item.Masses)
        let element = try iterator.nextItem(Item.MetalElements)
        return "\(mass) of \(element) ore"
    }
    
    private func makeClothes() {
        self.descriptor.append(index: Item.Sizes.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Colors.oneIndexAtRandom())
        self.descriptor.append(index: Item.Clothes.oneIndexAtRandom())
    }
    
    private func describeClothes(iterator:DescriptorIterator) throws -> String {
        let size = try iterator.nextOptionalItem(Item.Sizes)
        let aspect = try iterator.nextOptionalItem(Item.Aspects)
        let color = try iterator.nextItem(Item.Colors)
        let clothing = try iterator.nextItem(Item.Clothes)
        return "\(aspect) \(size) \(color) \(clothing)"
    }
    
    private func makeBook() {
        let style = Int(arc4random_uniform(3))
        
        self.descriptor.append(value: style)
        
        switch style {
            
        case 0:
            self.descriptor.append(index: Item.Sizes.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Topics.oneIndexAtRandom())
            
        case 1:
            self.descriptor.append(index: Item.Lengths.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Topics.oneIndexAtRandom())
            
        case 2:
            self.descriptor.append(index: Item.Weights.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Colors.oneIndexAtRandom(nilStrategy: .equalChance))
            self.descriptor.append(index: Item.Topics.oneIndexAtRandom())
            
        default:
            break
        }
    }
    
    private func describeBook(iterator:DescriptorIterator) throws -> String {
        let style:Int = try iterator.next()
        
        switch style {
            
        case 0:
            let size = try iterator.nextOptionalItem(Item.Sizes)
            let color = try iterator.nextOptionalItem(Item.Colors)
            let topic = try iterator.nextItem(Item.Topics)
            return "\(size) \(color) ^book of \(topic)"
            
        case 1:
            let length = try iterator.nextOptionalItem(Item.Lengths)
            let color = try iterator.nextOptionalItem(Item.Colors)
            let topic = try iterator.nextItem(Item.Topics)
            return "\(length) \(color) ^book of \(topic)"
            
        case 2:
            let weight = try iterator.nextOptionalItem(Item.Weights)
            let color = try iterator.nextOptionalItem(Item.Colors)
            let topic = try iterator.nextItem(Item.Topics)
            return "\(weight) \(color) ^book of \(topic)"
            
        default:
            return ""
            
        }
    }
    
    private func makeUtensil() {
        
        self.descriptor.append(index: Item.Aspects.oneIndexAtRandom(nilStrategy: .equalChance))
        self.descriptor.append(index: Item.Materials.oneIndexAtRandom())
        self.descriptor.append(index: Item.Utensils.oneIndexAtRandom())
        
    }
    
    private func describeUtensil(iterator:DescriptorIterator) throws -> String {
        
        let aspect = try iterator.nextOptionalItem(Item.Aspects)
        let material = try iterator.nextItem(Item.Materials)
        let utensil = try iterator.nextItem(Item.Utensils)
        
        return "\(aspect) \(material) \(utensil)"
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
