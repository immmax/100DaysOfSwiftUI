//
//  HabitItem.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/29/23.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var status: String
    var isFavorite: Bool
    var completionCount: Int
}
