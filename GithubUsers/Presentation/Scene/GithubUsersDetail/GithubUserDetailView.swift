//
//  GithubUserDetailView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUserDetailView: View {
    @StateObject var viewModel: GithubUserDetailViewModel

    init(user: User?) {
        self._viewModel = .init(wrappedValue: GithubUserDetailViewModel(user: user ?? .emptyUser))
    }

    var body: some View {
        Text(viewModel.user.login)
            .navigationTitle("User Details")
    }
}
