//
//  HabitItem.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/29/23.
//

import Foundation

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int
}
