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

    private let fetchable: UserDetailFetchable

    @Published var isLoading: Bool = true
    @Published var userDetail: UserDetail?

    init(userLogin: String, fetchable: UserDetailFetchable = FetchUserDetailService()) {
        self.userLogin = userLogin
        self.fetchable = fetchable
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

        if let userDetail = try? await self.fetchable.fetchUserDetail(login: self.userLogin) {
            self.userDetail = userDetail
        }
    }
}
