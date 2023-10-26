//
//  FaceRecallApp.swift
//  FaceRecall
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

@main
struct FaceRecallApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
