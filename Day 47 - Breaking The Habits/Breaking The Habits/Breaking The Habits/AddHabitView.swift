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
    
    @State private var name = ""
    @State private var description = ""
    @State private var completionCount = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .submitLabel(.next)
                
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Habit")
            .toolbar {
                Button("Save") {
                    let item = HabitItem(name: name, description: description, completionCount: completionCount)
                    habits.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
