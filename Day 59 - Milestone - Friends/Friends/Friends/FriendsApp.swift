//
//  FriendsApp.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
