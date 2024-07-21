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
                UserListView(users: viewModel.users) { user in
                    self.selectedUserLogin = user.login
                    self.navigateToDetail = true
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
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView("Loading Users...")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Github Users") // Warning requires afterScreenUpdates:YES on simulator - Bug os
        }
    }
}

struct UserListView: View {
    let users: [User]
    let selectedRow: (User) -> Void

    var body: some View {
        List(users, id: \.login) { user in
            VStack(alignment: .leading, spacing: .zero) {
                Button(action: {
                    selectedRow(user)
                }, label: {
                    UserRowView(user: user)
                })
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .spacingXSS, leading: .spacingM, bottom: .spacingXSS, trailing: .spacingM))
        }
        .listStyle(.plain)
    }
}

struct UserRowView: View {
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
