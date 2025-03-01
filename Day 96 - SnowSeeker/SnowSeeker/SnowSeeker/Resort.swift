//
//  Resort.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/1/25.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
//    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    
    
    static func == (lhs: Resort, rhs: Resort) -> Bool {
        lhs.id == rhs.id
    }
}
