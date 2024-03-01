//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
