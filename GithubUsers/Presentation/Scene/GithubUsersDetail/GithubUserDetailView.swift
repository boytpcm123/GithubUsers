//
//  GithubUserDetailView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUserDetailView: View {

    @StateObject var viewModel: GithubUserDetailViewModel

    init(userLogin: String) {
        self._viewModel = .init(
            wrappedValue: GithubUserDetailViewModel(userLogin: userLogin)
        )
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: .spacingXL) {
                    if let userDetail = viewModel.userDetail, !viewModel.isLoading {
                        CardView(
                            avatar: userDetail.avatarUrl,
                            title: userDetail.login,
                            content: userDetail.location
                        )

                        UserOtherInfoView(userDetail: userDetail)

                        Spacer()
                    } else if viewModel.isLoading {
                        ProgressView("Getting User Detail...")
                    } else {
                        Text("Server is not reachable.")
                    }
                }
                .padding(.spacingXXS)
            }
            .refreshable {
                await self.viewModel.refresh()
            }
            .task {
                await self.viewModel.fetchUserDetail()
            }
        }
        .padding(.spacingM)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("User Details")
        .backToolbarItem()
    }
}

#Preview {
    NavigationView {
        GithubUserDetailView(userLogin: "mojombo")
    }
}
