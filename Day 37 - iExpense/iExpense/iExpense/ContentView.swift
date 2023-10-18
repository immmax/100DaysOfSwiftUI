//
//  ContentView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expences = Expences()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Business") {
                    ForEach(expences.items) { item in
                        if item.type == "Business" {
                            ExpenseItemView(item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Personal") {
                    ForEach(expences.items) { item in
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
                AddView(expenses: expences)
            }
            
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expences.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
