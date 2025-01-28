//
//  ContentView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = Habits()
    
    var body: some View {
        NavigationStack {
            HabitsListView(habits: $habits)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            AddHabitView(habits: $habits)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationTitle("My Habits")
        }
    }
}

#Preview {
    ContentView()
}
