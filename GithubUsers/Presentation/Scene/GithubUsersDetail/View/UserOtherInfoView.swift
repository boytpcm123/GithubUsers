//
//  UserOtherInfoView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserOtherInfoView: View {

    let followersText: String?
    let followingText: String?
    let htmlUrl: String?

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingM) {
            HStack(alignment: .center, spacing: .spacingXXLL) {
                if let followersText, followersText.isNotEmpty {
                    IconInfoView(
                        image: "person.2.fill",
                        value: followersText,
                        content: "Follower"
                    )
                }
                if let followingText, followingText.isNotEmpty {
                    IconInfoView(
                        image: "medal.fill",
                        value: followingText,
                        content: "Following"
                    )
                }

            }
            .frame(maxWidth: .infinity)

            if let htmlUrl, htmlUrl.isNotEmpty {
                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text("Blog")
                        .font(.cardTitle)
                    Text(htmlUrl)
                        .font(.cardSubtitle)
                        .foregroundColor(.textSecondary)
                }
            }
        }
    }
}

#Preview {
    VStack {
        UserOtherInfoView(
            followersText: "100+",
            followingText: "10+",
            htmlUrl: "https://github.com/takeo"
        )
        UserOtherInfoView(
            followersText: "",
            followingText: "200",
            htmlUrl: ""
        )
    }
    .padding()
}
