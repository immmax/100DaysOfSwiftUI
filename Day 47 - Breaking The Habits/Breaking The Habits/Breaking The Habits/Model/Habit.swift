//
//  Habit.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/29/23.
//

import Foundation

struct Keys {
    static let habits = "habits"
    static let activityItems = "activityItems"
}

struct Habit: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var completionCount: Int = 0
    
    mutating func complete() {
        completionCount += 1
    }
}

@Observable
class Habits {
    var items: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: Keys.habits)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Keys.habits) {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
