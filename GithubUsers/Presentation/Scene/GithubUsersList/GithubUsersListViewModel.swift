//
//  GithubUsersListViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

@MainActor
class GithubUsersListViewModel: ObservableObject {

    @Published var isLoading: Bool = true
    @Published var hasMoreUsers: Bool = true
    @Published var users: [User] = []

    private let fetchable: UsersFetchable

    private(set) var since: Int = 0
    private let itemsPerPage: Int = 20

    init(fetchable: UsersFetchable = NetworkManager()) {
        self.fetchable = fetchable
    }
}

extension GithubUsersListViewModel {
    func refresh() async {
        self.since = 0
        self.isLoading = true
        await self.fetchUsers()
    }

    func fetchUsers() async {
        guard self.isLoading else { return }
        defer {
            self.isLoading = false
        }

        do {
            let users = try await self.fetchable.fetchUsers(
                perPage: self.itemsPerPage,
                since: self.since
            )

            if since == 0 {
                self.users = users
            } else {
                self.users += users
            }

            print("Requesting since \(since)")

            // If number of users less than itemsPerPage -> No more page
            hasMoreUsers = users.count == itemsPerPage
        } catch let error {
            hasMoreUsers = false
            print(error.localizedDescription)
        }
    }

    func fetchMoreUsers() async {
        guard !self.isLoading, let lastUser = self.users.last else { return }
        self.isLoading = true
        // Get the id of last user to request next page base on the document
        // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
        since = lastUser.id
        await fetchUsers()
    }
}
