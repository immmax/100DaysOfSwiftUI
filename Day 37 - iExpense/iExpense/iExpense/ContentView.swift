//
//  ContentView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expences()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            ExpenseItemView(item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            ExpenseItemView(item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
//                ForEach(expences.items) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(item.name)
//                                .font(.headline)
//                            Text(item.type)
//                        }
//                        Spacer()
//                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
//                    }
//                }
//                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
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
