//
//  HabitView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 6/30/23.
//

import SwiftUI

struct HabitView: View {
//    @StateObject var activities = Activities()
    @State private var isFavorite = false
    @State private var showingAddActivity = false
    
    var item: HabitItem

    var body: some View {
        NavigationStack {
            VStack {
                Text(item.description)
                    .opacity(0.7)
                ActivitiesView(habitID: item.id)
            }
            .navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddActivity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .tint(.blue)
                    .buttonStyle(.bordered)
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(habitID: item.id)
                    .presentationDetents([.height(200), .height(200)])
            }
        }
    }
    
    func addActivity(item: HabitItem, comment: String) {
        // adding one activity
        item.activities.append(ActivityItem( habitID: item.id,
                                             date: Date.now,
                                             comment: comment))
    }
}

struct HabitView_Previews: PreviewProvider {
    static var isFavorite = true
    
    static var demoItem = HabitItem(name: "Demo Habit Name",
                                    description: "Demo Habit Description",
                                    activities: Activities())
//                                    status: "house",
//                                    isFavorite: isFavorite,
//                                    completionCount: 25)
    
    static var previews: some View {
        HabitView(item: demoItem)
    }
}
