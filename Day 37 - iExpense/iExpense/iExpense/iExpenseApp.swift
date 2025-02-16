//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
