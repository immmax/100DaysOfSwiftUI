//
//  HabitsListView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct HabitsListView: View {
    @Binding var habits: Habits
    @Namespace private var namespace
    
    var body: some View {
        if habits.items.isEmpty {
            ContentUnavailableView(
                "No Habits",
                systemImage: "waveform.path.ecg",
                description: Text(
                    "Add new habits by tapping the plus button in the top right corner."
                )
            )
            .preferredColorScheme(.dark)
            
        } else {
            
            List {
                ForEach(habits.items) { habit in
                    NavigationLink(value: habit) {
                        HabitListCell(habit)
                            .matchedTransitionSource(id: "cell", in: namespace)
                    }
                }
                .onDelete(perform: deleteHabit)
            }
            .listStyle(.plain)
            .navigationDestination(for: Habit.self) { selection in
                HabitDetailView(habits: $habits, selectedHabit: .constant(selection))
                    .navigationTransition(.zoom(sourceID: "cell", in: namespace))
            }
        }
    }
    
    func deleteHabit(atOffset: IndexSet) {
        for index in atOffset {
            habits.items.remove(at: index)
        }
    }
}

#Preview {
    HabitsListView(habits: .constant(MockData.init().habits))
}
