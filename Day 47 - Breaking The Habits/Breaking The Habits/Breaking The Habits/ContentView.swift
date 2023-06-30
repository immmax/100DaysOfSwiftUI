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
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .opacity(0.7)
                            }
                            Spacer()
                            Text("Count: \(item.completionCount)")
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                // Edit habit item action
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
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
