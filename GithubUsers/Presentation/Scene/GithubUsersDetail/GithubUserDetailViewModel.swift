//
//  GithubUserDetailViewModel.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation
import Combine

class GithubUserDetailViewModel: ObservableObject {
    let user: User

    init(user: User) {
        self.user = user
    }
}
