//
//  GithubUsersListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUsersListView: View {
    @StateObject var viewModel: GithubUsersListViewModel = GithubUsersListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users, id: \.id) { user in
                NavigationLink {
                    GithubUserDetailView(user: user)
                } label: {
                    Text(user.login)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Github Users")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView("Loading Users...")
                }
            }
        }
    }
}

#Preview {
    GithubUsersListView()
}
