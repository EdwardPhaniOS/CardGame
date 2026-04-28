//
//  SetGame.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import SwiftUI

@Observable
class GameViewModel {
    // MARK: - Properties

    var boardSlots: [SetCard?] = Array(repeating: nil, count: 18)
    var selectedCards: Set<SetCard> = []
    var score: Int = 0

    private var deck: [SetCard] = []

    // MARK: - Init

    init() {
        createBoard()
    }

    // MARK: - Public API

    func selectCard(card: SetCard) {
        guard boardSlots.contains(where: { $0 == card }) else { return }

        if selectedCards.contains(card) {
            selectedCards.remove(card)
            return
        }

        if selectedCards.count == 3 {
            selectedCards.removeAll()
        }

        selectedCards.insert(card)

        guard isSet(Array(selectedCards)) else { return }

        score += 1
        resolveMatchedCards(matching: selectedCards)
    }

    func showHint() {
        let validSet = findSetOnBoard()
        let twoCards = validSet.prefix(2)
        selectedCards = Set(twoCards)
    }

    // MARK: - Game Flow Helper

    private func resolveMatchedCards(matching matchedCards: Set<SetCard?>) {
        let matchedIndices = boardSlots.indices.filter { index in
            let card = boardSlots[index]
            return matchedCards.contains(card)
        }

        let replacementCards = drawCards(count: matchedIndices.count)

        withAnimation {
            selectedCards.removeAll()

            for index in matchedIndices {
                boardSlots[index] = nil
            }

            for (index, card) in zip(matchedIndices, replacementCards) {
                boardSlots[index] = card
            }
        }
    }

    private func findSetOnBoard() -> Set<SetCard> {
        let cards = boardSlots.compactMap { $0 }

        for i in 0..<cards.count {
            for j in i+1..<cards.count {
                for k in j+1..<cards.count {
                    let possibleSet: Set<SetCard> = [cards[i], cards[j], cards[k]]
                    if isSet(Array(possibleSet)) {
                        return possibleSet
                    }
                }
            }
        }

        return []
    }

    private func isSet(_ cards: [SetCard]) -> Bool {
        guard cards.count == 3 else { return false }

        let allColors = cards.map { $0.color }
        let allCount = cards.map { $0.count }
        let allFill = cards.map { $0.fill }
        let allShape = cards.map { $0.shape }

        return allSameOrAllDifferent(allColors)
        && allSameOrAllDifferent(allCount)
        && allSameOrAllDifferent(allFill)
        && allSameOrAllDifferent(allShape)
    }

    private func allSameOrAllDifferent<Value: Hashable>(_ values: [Value]) -> Bool {
        let count = Set(values).count
        return count == 1 || count == 3
    }

    // MARK: - Create board

    private func createBoard() {
        var newDeck: [SetCard] = []

        for shape in CardShape.allCases {
            for fill in CardFill.allCases {
                for count in CardCount.allCases {
                    for color in CardColor.allCases {
                        let card = SetCard(shape: shape, count: count, color: color, fill: fill)
                        newDeck.append(card)
                    }
                }
            }
        }

        self.deck = newDeck.shuffled()

        let openingCards = drawCards(count: boardSlots.count)

        for index in 0..<boardSlots.count {
            boardSlots[index] = openingCards[index]
        }
    }

    private func drawCards(count: Int) -> [SetCard] {
        let cards = Array(deck.prefix(count))
        deck.removeFirst(cards.count)
        return cards
    }

}
