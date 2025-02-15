//
//  GithubUsersListViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

@MainActor
final class GithubUsersListViewModel: ObservableObject {

    let itemsPerPage: Int = 20
    private(set) var since: Int64 = 0

    @Published var isLoading: Bool = true
    @Published var hasMoreUsers: Bool = true
    @Published var refreshID: UUID = UUID()

    private let usersFetchable: UsersFetchable
    private let usersStore: UsersStore

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
        await self.fetchData()
        self.refreshID = UUID() // Force refresh list view when data changes
    }

    func fetchData() async {
        self.since = 0
        self.isLoading = true
        await self.fetchUsers()
    }

    func fetchMoreUsers(since: Int64) async {
        self.isLoading = true
        // Get the id of last user to request next page base on the document
        // https://docs.github.com/en/rest/users/users?apiVersion=2022-11-28
        self.since = since
        await self.fetchUsers()
    }

    private func fetchUsers() async {
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

            try await usersStore.save(users: users)
            print("saved users data")

            // If number of users less than itemsPerPage -> No more page
            hasMoreUsers = users.count == itemsPerPage
        } catch let error {
            print(error.localizedDescription)
            
        }
    }
}
