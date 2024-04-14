//
//  Roll.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 4/14/24.
//

import Foundation

struct Roll: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let numbers: [Int]
//    let type: Int
}
