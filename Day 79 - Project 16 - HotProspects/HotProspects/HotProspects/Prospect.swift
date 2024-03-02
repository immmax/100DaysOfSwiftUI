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
    var dateAdded = Date.now
    var isContacted: Bool
    
    init(name: String, email: String, isContacted: Bool) {
        self.name = name
        self.email = email
        self.isContacted = isContacted
    }
}

//class Prospect: Identifiable, Codable {
//    var id = UUID()
//    var name = "Anonymous"
//    var email = ""
//    fileprivate(set) var isContacted = false
//}

//@MainActor class Prospects: ObservableObject {
//    @Published var people: [Prospect]
//    
//    init() {
//        people = []
//    }
//    
//    func toggle(_ prospect: Prospect) {
//        objectWillChange.send()
//        prospect.isContacted.toggle()
//    }
//}
