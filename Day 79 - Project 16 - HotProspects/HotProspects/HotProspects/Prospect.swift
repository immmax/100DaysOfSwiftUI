//
//  Prospect.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 11/20/23.
//

import SwiftUI
import SwiftData

@Model
class Prospect {
    var name: String
    var email: String
    var dateAdded: Date
    var isContacted: Bool
    
    init(name: String, email: String, dateAdded: Date, isContacted: Bool) {
        self.name = name
        self.email = email
        self.dateAdded = dateAdded
        self.isContacted = isContacted
    }
}
