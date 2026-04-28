//
//  CardColor.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import SwiftUI

enum CardColor: CaseIterable {
    case red, green, blue

    var color: Color {
        switch self {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        }
    }
}

