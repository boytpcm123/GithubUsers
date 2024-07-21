//
//  IconInfoView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct IconInfoView: View {

    let image: String
    let value: String
    let content: String

    var body: some View {
        VStack(alignment: .center, spacing: .spacingXXS) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .padding(.spacingS)
                .frame(width: .iconXL, height: .iconXL)
                .background(Color.iconBackground)
                .cornerRadius(.radiusMSL)

            Text(value)
                .font(.iconText)

            Text(content)
                .font(.cardSubtitle)
                .foregroundColor(.textSecondary)
        }
    }
}

#Preview {
    HStack(spacing: .spacingXLL) {
        IconInfoView(
            image: "person.2.fill",
            value: "50",
            content: "Follower"
        )
        IconInfoView(
            image: "medal.fill",
            value: "10+",
            content: "Following"
        )
    }
}
