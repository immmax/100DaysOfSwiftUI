//
//  Expense.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

enum ExpenseType: String, Identifiable, CaseIterable {
    
    var id: Self { self }
    
    case business = "Business"
    case personal = "Personal"
}
