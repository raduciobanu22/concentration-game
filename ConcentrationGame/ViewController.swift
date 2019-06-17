//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Radu on 08/06/19.
//  Copyright © 2019 Radu Ciobanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet var cardsButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy var game = Concentration(pairsOfCards: (cardsButtons.count + 1) / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chooseRandomTheme()
    }


    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardsButtons.lastIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.reset()
        emoji.removeAll()
        chooseRandomTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardsButtons.indices {
            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : backgroundByTheme[theme!]![1]
            }
        }
        
        flipsLabel.text = "Flips: \(game.flips)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    var emojiChoices = [String]()
    var theme: String?
    var emoji = [Int:String]()
    
    var emojisByTheme = [
        "winter": ["🥶", "❄️", "⛄️", "🎅", "🎄", "⛷"],
        "animals": ["🐶", "🐰", "🐒", "🦋", "🐍", "🦍"],
        "halloween": ["👻", "🎃", "😈", "🧛🏾‍♂️", "🍬", "🧟‍♂️"]
    ]
    
    var backgroundByTheme = [
        "winter": [UIColor.blue, UIColor.green],
        "animals": [UIColor.green, UIColor.orange],
        "halloween": [UIColor.red, UIColor.purple]
    ]
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func chooseRandomTheme() {
        let themes = Array(emojisByTheme.keys)
        let randomThemeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        
        theme = themes[randomThemeIndex]
        emojiChoices = emojisByTheme[theme!]!
        
        view.backgroundColor = backgroundByTheme[theme!]![0]
        
        for index in cardsButtons.indices {
            cardsButtons[index].backgroundColor = backgroundByTheme[theme!]![1]
        }
    }
}

