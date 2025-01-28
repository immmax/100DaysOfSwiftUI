//
//  AddHabitView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/29/23.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var habits: Habits
    
    @State private var title = "New Habit"
    @State private var description = ""
    
    var isNotValidHabit: Bool {
        title == "New Habit" || title.isEmpty || description.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Description", text: $description)
                .submitLabel(.done)
                .buttonStyle(.borderedProminent)
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel", role: .destructive) { dismiss() }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: addHabit)
                    .disabled(isNotValidHabit)
            }
        }
    }
    
    func addHabit() {
        let item = Habit(title: title, description: description)
        habits.items.append(item)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddHabitView(habits: .constant(MockData.init().habits))
    }
}
