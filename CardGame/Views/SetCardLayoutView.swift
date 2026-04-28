//
//  SetCardView.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import SwiftUI

struct SetCardLayoutView: View {
    var card: SetCard
    var verticalSpacing: CGFloat = 2
    var horizontalSpacing: CGFloat = 5

    var body: some View {
        switch card.count {
        case .one:
            SetSymbolView(card: card)
        case .two:
            HStack(spacing: horizontalSpacing) {
                SetSymbolView(card: card)
                SetSymbolView(card: card)
            }
        case .three:
            VStack(spacing: verticalSpacing) {
                SetSymbolView(card: card)
                HStack(spacing: horizontalSpacing) {
                    SetSymbolView(card: card)
                    SetSymbolView(card: card)
                }
            }
        }
    }
}

#Preview {
    SetCardLayoutView(card: .example)
}
