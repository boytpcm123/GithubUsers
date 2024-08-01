//
//  GithubUsersApp.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 19/7/24.
//

import SwiftUI

@main
struct GithubUsersApp: App {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            GithubUsersListView()
                .environment(\.managedObjectContext, managedObjectContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                PersistenceController.save()
            default:
                print("")
            }
        }
    }
}
