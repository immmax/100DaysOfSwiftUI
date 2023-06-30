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
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Habit")
            .toolbar {
                Button("Add") {
                    let item = HabitItem(name: name, description: description, completionCount: 0)
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
