//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Maxim Datskiy on 2/14/25.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
