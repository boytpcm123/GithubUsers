//
//  CardView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct CardView: View {
    
    let avatar: URL?
    let title: String
    let content: String
    var isLink: Bool = false

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: .spacingM) {
                AsyncImage(url: avatar) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFit()
                    } else {
                        ProgressView()
                    }
                }
                .cardAvatar()

                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text(title.capitalized)
                        .font(.cardTitle)
                        .foregroundColor(.textPrimary)
                    if isLink, let url = URL(string: content) {
                        Divider()
                        Link(destination: url, label: {
                            Text(content)
                                .font(.cardLink)
                                .underline()
                                .foregroundColor(.textLink)
                        })
                    } else {
                        Text(content)
                            .font(.cardLink)
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
        .cardBackground()
    }
}
