//
//  Location.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/11/23.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
