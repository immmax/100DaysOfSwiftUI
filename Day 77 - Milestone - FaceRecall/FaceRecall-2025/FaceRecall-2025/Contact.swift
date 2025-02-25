//
//  Contact.swift
//  FaceRecall-2025
//
//  Created by Maxim Datskiy on 2/22/25.
//

import CoreLocation
import Foundation
import SwiftData

@Model
class Contact {
    var name: String
    var location: CLLocationCoordinate2D?
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, location: CLLocationCoordinate2D, photo: Data? = nil) {
        self.name = name
        self.location = location
        self.photo = photo
    }
}

struct Location {
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude,
                               longitude: longitude)
    }
}
