//
//  GithubUsersListViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

class GithubUsersListViewModel: ObservableObject {

    @Published var isLoading: Bool = true
    @Published var users: [User] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.users = User.mockList
            self.isLoading = false
        }
    }
}
