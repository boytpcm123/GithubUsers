//
//  CardView.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct CardView: View {
    
    let avatar: String
    let title: String
    let content: String
    var isLink: Bool = false

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: .spacingM) {
                if let avatarUrl = URL(string: avatar) {
                    AsyncImage(url: avatarUrl) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else {
                            ProgressView()
                        }
                    }
                    .cardAvatar()
                } else {
                    Image(systemName: "person.crop.circle").cardAvatar()
                }

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
                    } else if !content.isEmpty {
                        Divider()
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable().scaledToFit()
                                .frame(height: .iconS)
                                .foregroundColor(.textSecondary)
                            Text(content)
                                .font(.cardLink)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
            }
        }
        .cardBackground()
    }
}

#Preview {
    VStack {
        CardView(
            avatar: "https://avatars.githubusercontent.com/u/1?v=4",
            title: "mojombo",
            content: "https://github.com/mojombo",
            isLink: true
        )

        CardView(
            avatar: "",
            title: "defunkt",
            content: "Vietnam",
            isLink: false
        )
    }
    .padding()

}
