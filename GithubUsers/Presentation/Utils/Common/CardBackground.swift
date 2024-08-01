//
//  CardBackground.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.spacingM)
            .background(Color.cardBackground)
            .cornerRadius(.radiusSL)
            .shadow(color: Color.cardShadow, radius: .radiusS, x: 1, y: 2)
    }
}

