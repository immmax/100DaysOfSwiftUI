//
//  Expenses.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import Observation
import Foundation

struct Keys {
    static let items = "items"
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: Keys.items)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: Keys.items) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
