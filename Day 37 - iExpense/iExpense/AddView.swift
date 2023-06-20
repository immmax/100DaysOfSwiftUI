//
//  AddView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 6/15/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expences
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    if name != "" {
                        if amount != 0.0 {
                            let item = ExpenseItem(name: name, type: type, amount: amount)
                            expenses.items.append(item)
                            dismiss()
                        } else {
                            alertMessage = "Amount of an expense can't be zero!"
                            showingAlert = true
                        }
                    } else {
                        alertMessage = "Name of an expense can't be empty!"
                        showingAlert = true
                    }
                    
                    
                }
            }
        }
        .alert("Oops!", isPresented: $showingAlert) {
        } message: {
            Text(alertMessage)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expences())
    }
}
