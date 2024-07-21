//
//  GithubUserDetailViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: ObservableObject {

    let userLogin: String

    @Published var isLoading: Bool = false
    @Published var userDetail: UserDetail? = UserDetail.mock

    init(userLogin: String) {
        self.userLogin = userLogin
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.userDetail = UserDetail.mock
//            self.isLoading = false
//        }
    }
}
