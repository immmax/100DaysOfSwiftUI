//
//  ContentView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            ExpenseItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            ExpenseItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
