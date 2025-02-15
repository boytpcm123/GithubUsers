//
//  GithubUsersListView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUsersListView: View {
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \UserEntity.id, ascending: true)
        ],
        animation: .default
    )
    private var users: FetchedResults<UserEntity>

    @StateObject var viewModel: GithubUsersListViewModel = GithubUsersListViewModel()
    
    @State private var navigateToDetail = false
    @State private var selectedUserLogin: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                UserListView(
                    users: users,
                    isLoading: viewModel.isLoading
                ) { userLogin in
                    self.selectedUserLogin = userLogin
                    self.navigateToDetail = true
                } refreshAction: {
                    // Refresh data list
                    Task {
                        await self.viewModel.refresh()
                    }
                } footer: {
                    if !users.isEmpty && viewModel.hasMoreUsers {
                        HStack(alignment: .center) {
                            ProgressView("Loading More Users...")
                        }
                        .frame(maxWidth: .infinity)
                        .task {
                            let since = users.last?.id ?? 0
                            await viewModel.fetchMoreUsers(since: since)
                        }
                    }
                }
                .id(viewModel.refreshID) // Add refresh ID here to refresh list view
                .task {
                    // First check empty data then fetch
                    if users.isEmpty {
                        await self.viewModel.fetchData()
                    }
                }
                
                // Navigation to detail
                NavigationLink(
                    destination: GithubUserDetailView(
                        GithubUserDetailViewModel(userLogin: selectedUserLogin)
                    ),
                    isActive: $navigateToDetail
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .overlay {
                if users.isEmpty && viewModel.isLoading {
                    ProgressView("Loading Users...")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Github Users") // Warning requires afterScreenUpdates:YES on simulator - Bug os
        }
    }
}

#Preview {
    GithubUsersListView(
        viewModel: GithubUsersListViewModel(
            usersFetchable: UsersFetchableMock(),
            usersStore: UsersStoreService(
                context: PersistenceController.preview.container.viewContext
            )
        )
    )
    .environment(
        \.managedObjectContext,
         PersistenceController.preview.container.viewContext
    )
}
