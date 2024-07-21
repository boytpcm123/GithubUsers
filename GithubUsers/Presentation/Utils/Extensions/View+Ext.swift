//
//  View+Ext.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import SwiftUI

extension View {
    func cardBackground() -> some View {
        modifier(CardBackground())
    }

    func cardAvatar() -> some View {
        modifier(CardAvatar())
    }
}
