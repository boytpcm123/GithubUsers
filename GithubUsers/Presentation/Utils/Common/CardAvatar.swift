//
//  CardAvatar.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct CardAvatar: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            content
            .frame(width: .avatarXL, height: .avatarXL)
            .background(Color.avatarPlaceHolderBg)
            .cornerRadius(.radiusXL)
            .padding(.horizontal, .spacingXXS)
            .padding(.top, .spacingXXS)
            .padding(.bottom, .spacingXSS)
        }
        .background(Color.avatarBg)
        .cornerRadius(.radiusM)
    }
}
