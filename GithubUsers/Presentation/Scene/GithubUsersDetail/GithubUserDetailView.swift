//
//  GithubUserDetailView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUserDetailView: View {

    @Environment(\.dismiss) var dimiss

    @StateObject var viewModel: GithubUserDetailViewModel

    init(userLogin: String) {
        self._viewModel = .init(wrappedValue: GithubUserDetailViewModel(userLogin: userLogin))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingXL) {
            if let userDetail = viewModel.userDetail, !viewModel.isLoading {
                CardView(
                    avatar: userDetail.avatarUrl,
                    title: userDetail.login,
                    content: userDetail.location
                )

                UserOtherInfoView(userDetail: userDetail)

                Spacer()
            } else {
                ProgressView("Getting User Detail")
            }
        }
        .padding(.spacingM)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("User Details")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dimiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.headline)
                            .foregroundColor(.iconAction)
                    }
                )
            }
        }
    }
}

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
    NavigationView {
        GithubUserDetailView(userLogin: "mojombo")
    }
}
