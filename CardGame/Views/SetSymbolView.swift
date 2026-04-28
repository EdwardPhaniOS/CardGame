//
//  SetSymbolView.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import SwiftUI

struct SetSymbolView: View {
    var card: SetCard
    var symbolSize: CGFloat = 32

    var body: some View {
        Image(systemName: card.shape.systemName(cardFill: card.fill))
            .foregroundStyle(card.color.color)
            .font(.system(size: symbolSize))
    }
}

#Preview {
    SetSymbolView(card: .example)
}
