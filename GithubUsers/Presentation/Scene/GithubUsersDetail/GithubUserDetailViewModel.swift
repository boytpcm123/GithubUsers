//
//  GithubUserDetailViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

@MainActor
class GithubUserDetailViewModel: ObservableObject {

    let userLogin: String

    private let userDetailFetchable: UserDetailFetchable
    private let userDetailStore: UserDetailStore

    @Published var isLoading: Bool = true

    init(
        userLogin: String,
        userDetailFetchable: UserDetailFetchable = FetchUserDetailService(),
        userDetailStore: UserDetailStore = UserDetailStoreService()
    ) {
        self.userLogin = userLogin
        self.userDetailFetchable = userDetailFetchable
        self.userDetailStore = userDetailStore
    }
}

extension GithubUserDetailViewModel {
    func refresh() async {
        self.isLoading = true
        await self.fetchUserDetail()
    }

    func fetchUserDetail() async {
        guard self.isLoading else { return }
        defer {
            self.isLoading = false
        }

        print("Get user login", userLogin)

        do {
            let userDetail = try await self.userDetailFetchable.fetchUserDetail(login: self.userLogin)
            try await userDetailStore.save(user: userDetail)
        } catch {
            print(error.localizedDescription)
        }

    }
}
