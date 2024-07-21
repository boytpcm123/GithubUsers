//
//  UserListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserListView<Content: View>: View {
    let users: [User]
    let footer: Content
    let selectedRow: (User) -> Void

    init(users: [User], @ViewBuilder footer: () -> Content, selectedRow: @escaping (User) -> Void = { _ in }) {
        self.users = users
        self.footer = footer()
        self.selectedRow = selectedRow
    }

    var body: some View {
        List {
            ForEach(users, id: \.id) { user in
                VStack(alignment: .leading, spacing: .zero) {
                    Button(action: {
                        selectedRow(user)
                    }, label: {
                        UserRowView(user: user)
                    })
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(.init(
                top: .spacingXSS,
                leading: .spacingM,
                bottom: .spacingXSS,
                trailing: .spacingM)
            )
            footer.listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    UserListView(
        users: User.mockList,
        footer: { EmptyView() }
    )
}
