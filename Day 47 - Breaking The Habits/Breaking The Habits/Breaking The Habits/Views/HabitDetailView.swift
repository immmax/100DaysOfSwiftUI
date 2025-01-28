//
//  HabitDetailView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/30/23.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var habits: Habits
    @Binding var selectedHabit: Habit
    
    var body: some View {
        Form {
            Section("Description") {
                Text(selectedHabit.description)
            }
            
            Section("Progress") {
                LabeledContent("Completion Count", value: "\($selectedHabit.completionCount.wrappedValuecut)")
                
                Button {
                    if let index = habits.items.firstIndex(of: selectedHabit) {
                        habits.items[index].complete()
                    }
//                    dismiss()
                } label: {
                    Text("Complete")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .navigationTitle(selectedHabit.title)
    }
}

#Preview {
    NavigationStack {
        HabitDetailView(habits: .constant(MockData.init().habits), selectedHabit: .constant(MockData.habit))
    }
}
