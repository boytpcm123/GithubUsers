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
    let isLink: Bool 

    init(avatar: String?, title: String, content: String?, isLink: Bool = false) {
        self.avatar = avatar ?? ""
        self.title = title
        self.content = content ?? ""
        self.isLink = isLink
    }

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
                    Image(systemName: "person.crop.circle")
                        .cardAvatar()
                }

                VStack(alignment: .leading, spacing: .spacingXS) {
                    Text(title.capitalized)
                        .font(.cardTitle)
                        .foregroundColor(.textPrimary)
                        .lineLimit(1)

                    if content.isNotEmpty {
                        Divider()
                        if isLink, let url = URL(string: content) {
                            Link(destination: url, label: {
                                Text(content)
                                    .font(.cardLink)
                                    .underline()
                                    .foregroundColor(.textLink)
                                    .lineLimit(1)
                            })
                        } else {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable().scaledToFit()
                                    .frame(height: .iconS)
                                    .foregroundColor(.textSecondary)
                                Text(content)
                                    .font(.cardLink)
                                    .foregroundColor(.textSecondary)
                                    .lineLimit(1)
                            }
                        }
                    } else {
                        Color(.clear)
                            .frame(maxWidth: .infinity)
                            .frame(height: 0)
                    }
                }
                .frame(maxWidth: .infinity)
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
            content: "https://github.com/mojombomojombomojombomojombo",
            isLink: true
        )

        CardView(
            avatar: "https://avatars.githubusercontent.com/u/25?v=4",
            title: "githubusercontent",
            content: "Vietnam",
            isLink: false
        )

        CardView(
            avatar: "",
            title: "defunkt",
            content: "",
            isLink: false
        )
    }
    .padding()

}
