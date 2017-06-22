//
// Pluralize.swift
//
// Adapted from: https://github.com/joshualat/Pluralize.swift

import Foundation

public class Pluralize {
    
    let _uncountables:[String] = [
        "access", "accommodation", "adulthood", "advertising", "advice", "aggression",
        "aid", "air", "alcohol", "anger", "applause", "arithmetic", "art",
        "assistance", "athletics", "attention", "bacon", "baggage", "ballet",
        "beauty", "beef", "beer", "biology", "bison", "botany", "bread", "butter",
        "carbon", "cash", "chaos", "cheese", "chess", "childhood", "clothing",
        "coal", "coffee", "commerce", "compassion", "comprehension", "content",
        "corps", "corruption", "cotton", "courage", "cream", "currency", "dancing",
        "danger", "data", "deer", "delight", "dignity", "dirt", "distribution",
        "dust", "economics", "education", "electricity", "employment", "engineering",
        "envy", "equipment", "ethics", "evidence", "evolution", "faith", "fame",
        "fish", "flour", "flu", "food", "freedom", "fuel", "fun", "furniture",
        "garbage", "garlic", "genetics", "gold", "golf", "gossip", "grammar",
        "gratitude", "grief", "ground", "guilt", "gymnastics", "hair", "happiness",
        "hardware", "harm", "hate", "hatred", "health", "heat", "height", "help",
        "homework", "honesty", "honey", "hospitality", "housework", "humour",
        "hunger", "hydrogen", "ice", "importance", "inflation", "information",
        "injustice", "innocence", "iron", "irony", "jealousy", "jelly", "judo",
        "karate", "kindness", "knowledge", "labour", "lack", "laughter", "lava",
        "leather", "leisure", "lightning", "linguistics", "litter", "livestock",
        "logic", "loneliness", "luck", "luggage", "machinery", "magic", "management",
        "mankind", "marble", "mathematics", "mayonnaise", "means", "measles", "meat",
        "methane", "milk", "money", "moose", "mud", "music", "nature", "news",
        "nitrogen", "nonsense", "nurture", "nutrition", "obedience", "obesity",
        "oil", "oxygen", "passion", "pasta", "patience", "permission", "physics",
        "poetry", "pollution", "poverty", "power", "pronunciation", "psychology",
        "publicity", "quartz", "racism", "rain", "relaxation", "reliability",
        "research", "respect", "revenge", "rice", "rubbish", "rum", "salad",
        "satire", "scissors", "seaside", "series", "shame", "sheep", "shopping",
        "silence", "sleep", "smoke", "smoking", "snow", "soap", "software", "soil",
        "sorrow", "soup", "species", "speed", "spelling", "steam", "stuff",
        "stupidity", "sunshine", "swine", "symmetry", "tennis", "thirst", "thunder",
        "toast", "tolerance", "toys", "traffic", "transporation", "travel", "trust",
        "understanding", "unemployment", "unity", "validity", "veal", "vengeance",
        "violence"]
    
    private let _rules:[(rule: String, template: String)] = [
        (rule: "(th)is$", template: "$1ese"),
        (rule: "(th)at$", template: "$1ose"),
        (rule: "(millen)ium$", template: "$1ia"),
        (rule: "(l)eaf$", template: "$1eaves"),
        (rule: "(r)oof$", template: "$1oofs"),
        (rule: "(gen)us$", template: "$1era"),
        (rule: "(embarg)o$", template: "$1oes"),
        (rule: "arf$", template: "$1arves"),
        (rule: "^(b|tabl)eau$", template: "$1eaux"),
        (rule: "^(append|matr)ix$", template: "$1ices"),
        (rule: "^(ind)ex$", template: "$1ices"),
        (rule: "^(a)pparatus$", template: "$1pparatuses"),
        (rule: "^(a)lumna$", template: "$1lumnae"),
        (rule: "^(alg|vertebr|vit)a$", template: "$1ae"),
        (rule: "^(d)ie$", template: "$1ice"),
        (rule: "(m|l)ouse$", template: "$1ice"),
        (rule: "^(p)erson$", template: "$1eople"),
        (rule: "^(o)x$", template: "$1xen"),
        (rule: "^(c)hild$", template: "$1hildren"),
        (rule: "(g)oose$", template: "$1eese"),
        (rule: "(t)ooth$", template: "$1eeth"),
        (rule: "lf$", template: "$1lves"),
        (rule: "(f)oot$", template: "$1eet"),
        (rule: "^(wo|work|fire)man$", template: "$1men"),
        (rule: "(potat|tomat|volcan)o$", template:"$1oes"),
        (rule: "(criteri|phenomen)on$", template:"$1a"),
        (rule: "(nebul)a", template:"$1ae"),
        (rule: "oof$", template:"$1ooves"),
        (rule: "ium$", template:"$1ia"),
        (rule: "um$", template:"$1a"),
        (rule: "oaf$", template:"$1oaves"),
        (rule: "(thie)f$", template:"$1ves"),
        (rule: "fe$", template:"$1ves"),
        (rule: "(buffal|carg|mosquit|torped|zer|vet|her|ech)o$", template:"$1oes"),
        (rule: "o$", template:"$1os"),
        (rule: "ch$", template:"$1ches"),
        (rule: "sis$", template:"$1ses"),
        (rule: "(corp)us$", template:"$1ora"),
        (rule: "(cact|nucle|alumn|bacill|fung|radi|stimul|syllab)us$", template:"$1i"),
        (rule: "(ax)is", template: "$1es"),
        (rule: "(sh|zz|ss)$", template:"$1es"),
        (rule: "x$", template:"$1xes"),
        (rule: "(t|sp|r|l|b)y$", template:"$1ies"),
        (rule: "s$", template:"$1ses"),
        (rule: "$", template:"$1s")]
    
    static let sharedInstance = Pluralize()
    
    public func pluralOf(word: String = "", count: Int = 2) -> String {
        
        if count == 1 || word.isEmpty || sortedArray(_uncountables, contains: word) {
            return word;
        }
        
        for pair in _rules {
            
            let newValue = regexReplace(input: word, pattern: pair.rule, template: pair.template)
            if newValue != word {
                return newValue
            }
        }
        
        return word;
    }
    
    private func regexReplace(input: String, pattern: String, template: String) -> String {
        
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: input.characters.count)
        let output = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: template)
        return output
    }

    private func sortedArray<T:Comparable>(_ inputArr:Array<T>, contains searchItem: T) -> Bool {
        
        var lowerIndex = 0;
        var upperIndex = inputArr.count - 1
        
        while (true) {
            let currentIndex = (lowerIndex + upperIndex)/2
            
            if(inputArr[currentIndex] == searchItem) {
                return true
            } else if (lowerIndex > upperIndex) {
                return false
            } else {
                if (inputArr[currentIndex] > searchItem) {
                    upperIndex = currentIndex - 1
                } else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
    }
}

public extension String {
    
    public func pluralize(count: Int = 2) -> String {
        return Pluralize.sharedInstance.pluralOf(word: self, count: count)
    }
}
