//
//  UserRowView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserRowView: View {
    let user: UserEntity

    init(user: UserEntity) {
        self.user = user
    }

    var body: some View {
        CardView(
            avatar: user.avatarUrl ?? "",
            title: user.login ?? "",
            content: user.htmlUrl ?? "",
            isLink: true
        )
    }
}

#Preview {
    VStack {
        if let user = CoreDataHelper.getTestUserEntity() {
            UserRowView(user: user)
        } else {
            EmptyView()
        }
    }
    .padding()
}
