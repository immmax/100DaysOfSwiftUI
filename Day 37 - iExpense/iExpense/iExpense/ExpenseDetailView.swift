//
//  ExpenseDetailView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

struct ExpenseDetailView: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(expense.amount < 10 ? .green : expense.amount < 100 ? .orange : .red)
        }
        .accessibilityElement()
        .accessibilityLabel(
            """
            \(expense.name),
            $ \(String(format: "%.2f", expense.amount))")
            """
        )
        .accessibilityHint(expense.type)
    }
    
    init(_ expense: Expense) {
        self.expense = expense
    }
}

#Preview {
    ExpenseDetailView(Expense(name: "PC Case", type: "Personal", amount: 84.99))
}
