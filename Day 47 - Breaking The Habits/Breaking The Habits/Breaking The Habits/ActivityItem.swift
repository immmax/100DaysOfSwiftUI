//
//  ActivityItem.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 7/1/23.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let date: Date
    let comment: String
}
