//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maxim Datskiy on 7/12/23.
//

import SwiftUI

struct StorageKeys {
    static let name = "name"
    static let streetAddress = "streetAddress"
    static let city = "city"
    static let zip = "zip"
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: StorageKeys.name) ?? "" {
        didSet {
            UserDefaults.standard.set(name, forKey: StorageKeys.name)
        }
    }
    
    var streetAddress = UserDefaults.standard.string(forKey: StorageKeys.streetAddress) ?? "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    
    var city = UserDefaults.standard.string(forKey: StorageKeys.city) ?? "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    
    var zip = UserDefaults.standard.string(forKey: StorageKeys.zip) ?? "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
           zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
