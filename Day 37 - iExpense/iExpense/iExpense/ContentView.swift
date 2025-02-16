//
//  ContentView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    @State private var expenseType: String = ""
    
    var body: some View {
        NavigationStack {
            ExpensesView(expenseType: expenseType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView()) {
                    Label("Add Expense", systemImage: "plus")
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        Text("Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                }
                
                Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                    Picker("Filter", selection: $expenseType) {
                        Text("All").tag("")
                        Text(ExpenseType.business.rawValue).tag(ExpenseType.business.rawValue)
                        Text(ExpenseType.personal.rawValue).tag(ExpenseType.personal.rawValue)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
