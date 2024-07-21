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
                } else {
                    ProgressView("Getting User Detail")
                }
            }
        }
        .padding(.spacingM)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("User Details")
        .backToolbarItem()
        .refreshable {
            print("Refresh data")
        }
    }
}

#Preview {
    NavigationView {
        GithubUserDetailView(userLogin: "mojombo")
    }
}
