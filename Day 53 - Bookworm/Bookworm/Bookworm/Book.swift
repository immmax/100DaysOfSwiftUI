//
//  Book.swift
//  Bookworm
//
//  Created by Maxim Datskiy on 2/13/25.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String?
    var author: String?
    var rating: Int16
    var genre: String?
    var review: String?
    var date: Date?
    
    init(title: String? = nil, author: String? = nil, rating: Int16, genre: String? = nil, review: String? = nil, date: Date? = nil) {
        self.title = title
        self.author = author
        self.rating = rating
        self.genre = genre
        self.review = review
        self.date = date
    }
    
    
}
