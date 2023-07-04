//
//  HabitView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/30/23.
//

import SwiftUI

struct HabitView: View {
    @StateObject var activities = Activities()
    @State private var isFavorite = false
    
    var item: HabitItem
    
    var body: some View {
        NavigationStack {
            ViewThatFits {
                Section("Description") {
                    Text(item.description)
                        .opacity(0.7)
                }
//                Toggle("Add to favorite", isOn: $isFavorite)
                Section {
                    ActivitiesView(activities: activities)
                }
            }
            .navigationTitle(item.name)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(.blue)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    func addActivity(comment: String) {
        // adding one activity
        activities.items.append(ActivityItem(date: Date.now, comment: comment))
//        var newItem = ActivityItem()
//        newItem.date = Date.now()
//        newItem.description = "I made it!"
//        
//        activities.items.append(newItem)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var isFavorite = true
    
    static var demoItem = HabitItem(name: "Demo Habit Name",
                                    description: "Demo Habit Description",
                                    status: "house",
                                    isFavorite: isFavorite,
                                    completionCount: 25)
    
    static var previews: some View {
        HabitView(item: demoItem)
    }
}
