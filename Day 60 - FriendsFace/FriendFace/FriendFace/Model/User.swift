//
//  User.swift
//  FriendFace
//
//  Created by Maxim Datskiy on 2/15/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
