//
//  ActivitiesView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 7/1/23.
//

import SwiftUI

struct ActivitiesView: View {
    @StateObject var activities = Activities()
    var habitID: UUID
    var body: some View {
        List {
            ForEach(activities.items) { item in
                LazyVStack(alignment: .leading) {
                    if item.id == habitID {
                        Text(item.date, format: .dateTime.year().month().day().hour().minute())
                            .font(.headline)
                            .opacity(0.5)
                        Text(item.comment)
                    }
                }
                .padding(.horizontal)
            }
            .onDelete(perform: removeActivityItem)
        }
    }
    
    func removeActivityItem(at offset: IndexSet) {
        activities.items.remove(atOffsets: offset)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    //static var activities = Activities()
    static var habitID = UUID()
    
    static var previews: some View {
        ActivitiesView(habitID: habitID)
    }
}
