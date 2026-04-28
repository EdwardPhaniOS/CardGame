//
//  SetCard.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import Foundation

struct SetCard: Identifiable, Hashable {
    let id: UUID = UUID()
    var shape: CardShape
    var count: CardCount
    var color: CardColor
    var fill: CardFill

    static let example: SetCard = SetCard(shape: .circle, count: .two, color: .blue, fill: .full)
}
