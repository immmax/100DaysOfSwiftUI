//
//  ExpensesView.swift
//  iExpense
//
//  Created by Maxim Datskiy on 2/15/25.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(ExpenseType.allCases) { expenseType in
                if expenses.count(where: { $0.type == expenseType.rawValue }) > 0 {
                    Section(expenseType.rawValue) {
                        ForEach(expenses) { expense in
                            if expense.type == expenseType.rawValue {
                                ExpenseDetailView(expense)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
    
    init(expenseType: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            if expenseType == "" {
                true
            } else {
                expense.type == expenseType
            }
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(expenseType: ExpenseType.business.rawValue,
                 sortOrder: [SortDescriptor(\Expense.name)])
}
