//
//  Card.swift
//  Flashzilla
//
//  Created by Maxim Datskiy on 3/2/24.
//

import Foundation

struct Card: Codable {
    var promt: String
    var answer: String
    
    static let example = Card(promt: "Who played the 13th Doctor in Doctor Who?",
                              answer: "Jodie Whittaker")
}
