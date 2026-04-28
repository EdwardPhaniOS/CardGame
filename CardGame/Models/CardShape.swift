//
//  CardShape.swift
//  CardGame
//
//  Created by Vinh Phan on 28/4/26.
//

import Foundation

enum CardShape: CaseIterable {
    case circle, square, triangle

    func systemName(cardFill: CardFill) -> String {
        let base = switch self {
        case .circle: "circle"
        case .square: "square"
        case .triangle: "triangle"
        }
        
        let suffix = switch cardFill {
        case .empty: ""
        case .rightHalf: ".righthalf.filled"
        case .full: ".fill"
        }
        
        return base + suffix
    }
}
