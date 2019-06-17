//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Radu on 13/06/19.
//  Copyright © 2019 Radu Ciobanu. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var flips: Int = 0
    var score: Int = 0
    
    private var indexOfOnlyCardWithFaceUp: Int?
    
    
    init(pairsOfCards: Int) {
        for _ in 1...pairsOfCards {
            let card = Card(identifier: Card.getIdentifier())
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        flips += 1
        
        if cards[index].isMatched {
            return
        }
        
        if let matchedIndex = indexOfOnlyCardWithFaceUp, index != matchedIndex {
            if cards[matchedIndex].identifier == cards[index].identifier {
                cards[matchedIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            } else if cards[index].seen {
                score -= 1
            }
            cards[index].isFaceUp = true
            indexOfOnlyCardWithFaceUp = nil
        } else {
            for flipDownIndex in cards.indices {
                if flipDownIndex != index {
                    cards[flipDownIndex].isFaceUp = false
                } else {
                    cards[flipDownIndex].isFaceUp = true
                }
            }
            indexOfOnlyCardWithFaceUp = index
        }
        cards[index].seen = true
    }
    
    
    func reset() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        indexOfOnlyCardWithFaceUp = nil
        flips = 0
        score = 0
    }
}
