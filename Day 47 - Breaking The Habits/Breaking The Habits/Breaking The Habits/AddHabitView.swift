//
//  AddHabitView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/29/23.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    enum FocusedField {
        case name, description
    }
    
    @FocusState private var focusedField: FocusedField?
    @State private var name = ""
    @State private var description = ""
//    @State private var completionCount = 0
//    @State private var isFavorite = false
    
    var body: some View {
        Form {
            Text("Add New Habit")
                .font(.largeTitle.bold())
            
            TextField("Name", text: $name)
                .focused($focusedField, equals: .name)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .description
                }
            
            TextField("Description", text: $description)
                .focused($focusedField, equals: .description)
                .submitLabel(.done)
                .buttonStyle(.borderedProminent)
                .onSubmit {
                    addHabit()
                    focusedField = nil
                    dismiss()
                }
        }
    }
    
    func addHabit() {
        let item = HabitItem(name: name,
                             description: description,
                             activities: Activities())
        habits.items.append(item)
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
