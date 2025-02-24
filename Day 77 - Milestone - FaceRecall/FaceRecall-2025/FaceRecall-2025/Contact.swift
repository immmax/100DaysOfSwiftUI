//
//  Contact.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import Foundation
import SwiftData

@Model
class Contact {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}
