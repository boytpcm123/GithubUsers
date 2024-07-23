//
//  GithubUserDetailView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUserDetailView: View {

    @StateObject var viewModel: GithubUserDetailViewModel

    @FetchRequest var userFetchedResults: FetchedResults<UserDetailEntity>

    init(_ viewModel: GithubUserDetailViewModel) {
        self._viewModel = .init(
            wrappedValue: viewModel
        )
        _userFetchedResults = FetchRequest<UserDetailEntity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "login == %@", viewModel.userLogin),
            animation: .default
        )
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: .spacingXL) {
                    if let userDetail = userFetchedResults.first, !viewModel.isLoading {
                        CardView(
                            avatar: userDetail.avatarUrl,
                            title: userDetail.login ?? "",
                            content: userDetail.location
                        )

                        UserOtherInfoView(
                            followersText: userDetail.followersText,
                            followingText: userDetail.followingText,
                            htmlUrl: userDetail.htmlUrl
                        )

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
                await self.viewModel.fetchData()
            }
            .task {
                if userFetchedResults.first == nil {
                    await self.viewModel.fetchData()
                }
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
        GithubUserDetailView(
            GithubUserDetailViewModel(
                userLogin: "mojombo",
                userDetailFetchable: UserDetailFetchableMock(),
                userDetailStore: UserDetailStoreService(
                    context: PersistenceController.preview.container.viewContext
                )
            )
        )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
