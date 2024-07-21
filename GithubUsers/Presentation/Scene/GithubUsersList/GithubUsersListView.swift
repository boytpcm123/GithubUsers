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
        VStack {
            HStack(alignment: .top, spacing: .spacingM) {
                AsyncImage(url: user.avatar) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
                .cardAvatar()

                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text(user.login.capitalized)
                        .font(.cardTitle)
                        .foregroundColor(.cardTitle)
                    if let html = user.html {
                        Divider()
                        Link(destination: html, label: {
                            Text(user.htmlUrl)
                                .font(.cardLink)
                                .underline()
                                .foregroundColor(.cardLink)
                        })
                    }
                }
            }
        }
        .cardBackground()
    }
}

#Preview {
    GithubUsersListView()
}
