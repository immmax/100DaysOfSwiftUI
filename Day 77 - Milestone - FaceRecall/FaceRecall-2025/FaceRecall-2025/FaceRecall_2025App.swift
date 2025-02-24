//
//  FaceRecall_2025App.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import SwiftData
import SwiftUI

@main
struct FaceRecall_2025App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Contact.self)
    }
}
