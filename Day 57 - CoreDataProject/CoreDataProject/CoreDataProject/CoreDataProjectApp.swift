//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 7/29/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
