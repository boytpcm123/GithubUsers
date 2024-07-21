//
//  GithubUsersListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUsersListView: View {
    @StateObject var viewModel: GithubUsersListViewModel = GithubUsersListViewModel()

    @State private var navigateToDetail = false
    @State private var selectedUserLogin: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                UserListView(users: viewModel.users) {
                    if !viewModel.users.isEmpty && viewModel.hasMoreUsers {
                        HStack(alignment: .center) {
                            ProgressView("Loading More Users...")
                        }
                        .frame(maxWidth: .infinity)
                        .task {
                           await viewModel.fetchMoreUsers()
                        }
                    }
                } selectedRow: { user in
                    self.selectedUserLogin = user.login
                    self.navigateToDetail = true
                }
                .task {
                    await self.viewModel.fetchUsers()
                }

                // Navigation to detail
                NavigationLink(
                    destination: GithubUserDetailView(userLogin: selectedUserLogin),
                    isActive: $navigateToDetail
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .overlay {
                if viewModel.users.isEmpty {
                    if viewModel.isLoading {
                        ProgressView("Loading Users...")
                    } else {
                        Text("Service is not reachable, Please try again later!")
                    }
                }

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Github Users") // Warning requires afterScreenUpdates:YES on simulator - Bug os
        }
    }
}

#Preview {
    GithubUsersListView()
}
