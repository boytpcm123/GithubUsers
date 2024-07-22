//
//  UserListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserListView<Content: View>: View {
    let users: [User]
    let isLoading: Bool
    let footer: Content
    let selectedRow: (User) -> Void
    let refreshAction: () -> Void

    init(
        users: [User],
        isLoading: Bool = false,
        @ViewBuilder footer: () -> Content,
        selectedRow: @escaping (User) -> Void = { _ in },
        refreshAction: @escaping () -> Void = {}
    ) {
        self.users = users
        self.isLoading = isLoading
        self.footer = footer()
        self.selectedRow = selectedRow
        self.refreshAction = refreshAction
    }

    var body: some View {
        List {
            if users.isEmpty && !isLoading {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Looks like there are no users.")
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
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
        }
        .listStyle(.plain)
        .refreshable {
            refreshAction()
        }
    }
}

#Preview {
    UserListView(
        users: User.mockList,
        footer: { EmptyView() }
    )
}
