//
//  EvpenseItemView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

struct ExpenseItemView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .orange : .red)
        }
        .accessibilityElement()
        .accessibilityLabel(
            """
            \(item.name),
            \(String(format: "%.2f", item.amount)) $")
            """
        )
        .accessibilityHint(item.type)
    }
    
    init(_ item: ExpenseItem) {
        self.item = item
    }
}

//#Preview {
//    ExpenseItemView()
//}
