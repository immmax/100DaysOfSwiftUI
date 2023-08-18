//
//  User.swift
//  Friends
//
//  Created by Maxim Datskiy on 8/14/23.
//

import SwiftUI

struct Response: Codable {
//    Почему-то не работает разбор JSON через эту структуру
    
    var users: [User]
}

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}

