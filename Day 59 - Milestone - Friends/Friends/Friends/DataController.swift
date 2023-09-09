//
//  DataController.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/18/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Friends")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy =  NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
