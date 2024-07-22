//
//  UserListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct UserListView<Content: View, Data: RandomAccessCollection>: View
where Data.Element: UserEntity {
    let users: Data
    let isLoading: Bool
    let footer: Content
    let selectedRow: (String) -> Void
    let refreshAction: () -> Void

    init(
        users: Data,
        isLoading: Bool = false,
        selectedRow: @escaping (String) -> Void = { _ in },
        refreshAction: @escaping () -> Void = {},
        @ViewBuilder footer: () -> Content
    ) {
        self.users = users
        self.isLoading = isLoading
        self.footer = footer()
        self.selectedRow = selectedRow
        self.refreshAction = refreshAction
    }

    init(
        users: Data,
        isLoading: Bool = false,
        selectedRow: @escaping (String) -> Void = { _ in },
        refreshAction: @escaping () -> Void = {}
    ) where Content == EmptyView {
        self.init(
            users: users,
            isLoading: isLoading,
            selectedRow: selectedRow,
            refreshAction: refreshAction) {
                EmptyView()
            }
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
                            selectedRow(user.login ?? "")
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
    VStack {
        NavigationView {
            UserListView(
                users: CoreDataHelper.getTestUserEntities()
            )
        }
//        NavigationView {
//            UserListView(users: []) {
//                Text("This is a footer view")
//            }
//        }
    }
}
