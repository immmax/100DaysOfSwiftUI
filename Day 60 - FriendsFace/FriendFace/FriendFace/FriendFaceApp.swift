//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
