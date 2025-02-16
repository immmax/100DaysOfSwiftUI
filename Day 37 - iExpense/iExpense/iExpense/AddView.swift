//
//  AddView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @State private var name = "New Expense"
    @State private var type = ExpenseType.business
    @State private var amount = 0.0
    
    var body: some View {
        NavigationStack {
            Form {
//                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        guard !name.isEmpty else {
                            alertMessage = "Name of an expense can't be empty!"
                            showingAlert = true
                            return
                        }
                        
                        if amount != 0.0 {
                            let expense = Expense(name: name, type: type.rawValue, amount: amount)
                            modelContext.insert(expense)
                            dismiss()
                        } else {
                            alertMessage = "Amount of an expense can't be zero!"
                            showingAlert = true
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) { dismiss() }
                }
            }
            .alert("Oops!", isPresented: $showingAlert) {
                
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    AddView()
}
