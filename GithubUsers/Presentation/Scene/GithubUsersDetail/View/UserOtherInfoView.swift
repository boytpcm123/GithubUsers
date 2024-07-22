//
//  UserOtherInfoView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserOtherInfoView: View {

    let userDetail: UserDetail

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingM) {
            HStack(alignment: .center, spacing: .spacingXXLL) {
                IconInfoView(
                    image: "person.2.fill",
                    value: userDetail.followersText,
                    content: "Follower"
                )
                IconInfoView(
                    image: "medal.fill",
                    value: userDetail.followingText,
                    content: "Following"
                )
            }
            .frame(maxWidth: .infinity)

            if userDetail.htmlUrl.isNotEmpty {
                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text("Blog")
                        .font(.cardTitle)
                    Text(userDetail.htmlUrl)
                        .font(.cardSubtitle)
                        .foregroundColor(.textSecondary)
                }
            }
        }
    }
}

#Preview {
    VStack {
        UserOtherInfoView(userDetail: UserDetail.mock)
    }
    .padding()
}
