//
//  Astronaut.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/16/23.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
