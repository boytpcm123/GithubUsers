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
                    Task {
                        // Refresh data list
                        await self.viewModel.refresh()
                    }
                } footer: {
                    if !users.isEmpty && viewModel.hasMoreUsers {
                        HStack(alignment: .center) {
                            ProgressView("Loading More Users...")
                        }
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.fetchMoreUsers()
                        }
                    }
                }
                .task {
                    await self.viewModel.fetchUsers()
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
