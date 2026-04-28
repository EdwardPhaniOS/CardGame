//
//  ContentView.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import SwiftUI

struct GameView: View {

    @State var viewModel: GameViewModel = GameViewModel()

    private let columnCount: Int = 3
    private let rowCount: Int = 6
    private let cardSpacing: CGFloat = 6

    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: cardSpacing), count: columnCount)
    }

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns, spacing: cardSpacing) {
                ForEach(viewModel.boardSlots.indices, id: \.self) { index in
                    Group {
                        if let card = viewModel.boardSlots[index] {
                            SetCardView(card: card, isSelected: viewModel.selectedCards.contains(card)) {
                                viewModel.selectCard(card: card)
                            }
                        } else {
                            Color.clear
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: columnCount, spacing: 30)
                    .containerRelativeFrame(.vertical, count: rowCount, spacing: 30)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .navigationTitle("Score: \(viewModel.score)")
            .toolbar {
                Button("Hint", systemImage: "lightbulb", action: viewModel.showHint)
            }
        }
    }
}

#Preview {
    GameView()
}
