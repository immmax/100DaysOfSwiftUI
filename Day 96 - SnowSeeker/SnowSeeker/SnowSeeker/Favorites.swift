//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/2/25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            if let savedData = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = savedData
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out all data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
