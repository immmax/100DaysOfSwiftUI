//
//  ContentView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    @State private var searchHabit = ""
    
//    var filteredHabits: [HabitItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits.items) { item in
                    NavigationLink {
                        HabitView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.description)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habits: habits)
                    .presentationDetents([.height(200), .height(200)])
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
