//
//  BackToolbarItem.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

struct BackToolbarItem: ViewModifier {

    @Environment(\.dismiss) var dimiss

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dimiss()
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .font(.headline)
                                .foregroundColor(.iconAction)
                        }
                    )
                }
            }
    }
}
