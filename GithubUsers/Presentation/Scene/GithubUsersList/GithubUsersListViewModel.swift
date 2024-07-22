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

    private let usersFetchable: UsersFetchable
    private let usersStore: UsersStore

    private(set) var since: Int64 = 0
    private let itemsPerPage: Int = 20

    init(
        usersFetchable: UsersFetchable = FetchUsersService(),
        usersStore: UsersStore = UsersStoreService()
    ) {
        self.usersFetchable = usersFetchable
        self.usersStore = usersStore
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
            print("Requesting Users list since \(since)")
            let users = try await self.usersFetchable.fetchUsers(
                perPage: self.itemsPerPage,
                since: self.since
            )

            self.since = users.last?.id ?? 0
            try await usersStore.save(users: users)

            // If number of users less than itemsPerPage -> No more page
            hasMoreUsers = users.count == itemsPerPage
        } catch let error {
            hasMoreUsers = false
            print(error.localizedDescription)
        }
    }

    func fetchMoreUsers() async {
        guard !self.isLoading else { return }
        self.isLoading = true
        // Get the id of last user to request next page base on the document
        // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
        await fetchUsers()
    }
}
