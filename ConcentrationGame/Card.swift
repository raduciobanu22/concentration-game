//
//  Card.swift
//  ConcentrationGame
//
//  Created by Radu on 13/06/19.
//  Copyright © 2019 Radu Ciobanu. All rights reserved.
//

import Foundation

struct Card {
    var identifier: Int
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var seen: Bool = false
    
    static var maxIdentifier: Int = 0
    
    static func getIdentifier() -> Int {
        maxIdentifier = maxIdentifier + 1
        return maxIdentifier
    }
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}
