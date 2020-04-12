//
//  ArrayExtensions.swift
//  AllTheLoot
//
//  Created by Andy Sherwood on 7/12/16.
//  Copyright © 2016 Andy Sherwood. All rights reserved.
//

import Foundation

enum RandomNilStrategy {
    case never
    case equalChance
}

extension Array {
    func oneAtRandom(nilStrategy strategy:RandomNilStrategy = .never) -> Element? {
        
        switch strategy {
            
        case .never:
            return self[Int(arc4random_uniform(UInt32(self.count)))]
            
        case .equalChance:
            let idx = Int(arc4random_uniform(UInt32(self.count+1)))
            if (idx == self.count) {
                return nil
            }
            return self[idx]
        }
    }
    
    func oneIndexAtRandom(nilStrategy strategy:RandomNilStrategy = .never) -> Int? {
        
        switch strategy {
            
        case .never:
            return Int(arc4random_uniform(UInt32(self.count)))
            
        case .equalChance:
            let idx = Int(arc4random_uniform(UInt32(self.count+1)))
            if (idx == self.count) {
                return nil
            }
            return idx
        }
    }
}
