//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maxim Datskiy on 7/12/23.
//

import SwiftUI

struct OrderDetails: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || name == " " ||
           streetAddress.isEmpty || streetAddress == " " ||
           city.isEmpty || city == " " ||
           zip.isEmpty  || zip == " " {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}


class Order: ObservableObject {
    @Published var details = OrderDetails()
    
}
