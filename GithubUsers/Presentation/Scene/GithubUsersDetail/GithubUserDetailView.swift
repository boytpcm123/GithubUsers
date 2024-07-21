//
//  GithubUserDetailView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import SwiftUI

struct GithubUserDetailView: View {
    @StateObject var viewModel: GithubUserDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(userLogin: String) {
        self._viewModel = .init(wrappedValue: GithubUserDetailViewModel(userLogin: userLogin))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacingM) {
            if let userDetail = viewModel.userDetail, !viewModel.isLoading {
                CardView(
                    avatar: userDetail.avatarUrl,
                    title: userDetail.login,
                    content: userDetail.location
                )
                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text("Blog")
                        .font(.cardTitle)
                    Text(userDetail.htmlUrl)
                        .font(.cardSubtitle)
                        .accentColor(.secondary)
                        .foregroundColor(.black)
                }
                Spacer()
            } else {
                ProgressView("Getting User Detail")
            }
        }
        .padding(.spacingM)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(
                action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(.headline)
                        .foregroundColor(.iconAction)
                }
            )
        )
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        GithubUserDetailView(userLogin: "mojombo")
    }
}
