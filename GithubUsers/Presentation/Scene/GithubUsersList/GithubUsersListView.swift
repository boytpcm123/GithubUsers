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
    @State private var selectedUser: User?

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.users, id: \.id) { user in
                    VStack(alignment: .leading, spacing: .zero) {
                        Button(action: {
                            self.selectedUser = user
                            self.navigateToDetail = true
                        }, label: {
                            UserRow(user: user)
                        })
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: .spacingXSS, leading: .spacingM, bottom: .spacingXSS, trailing: .spacingM))
                }
                .listStyle(.plain)
                .navigationTitle("Github Users")
                .navigationBarTitleDisplayMode(.inline)
                .overlay {
                    if viewModel.isLoading && viewModel.users.isEmpty {
                        ProgressView("Loading Users...")
                    }
                }

                // Navigation to detail
                NavigationLink(destination: GithubUserDetailView(user: selectedUser), isActive: $navigateToDetail) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        CardView(
            avatar: user.avatarUrl,
            title: user.login,
            content: user.htmlUrl,
            isLink: true
        )
    }
}

#Preview {
    GithubUsersListView()
}
