//
//  ActivitiesView.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 7/1/23.
//

import SwiftUI

struct ActivitiesView: View {
    @StateObject var activities = Activities()
    
    var body: some View {
        Form {
            ForEach(activities.items) { item in

                VStack {
                    Text(item.date, format: .dateTime.year().month().day().hour().minute())
                    Text("\(item.comment)")
                }
            }
            .onDelete(perform: removeActivityItem)
        }
    }
    
    func removeActivityItem(at offset: IndexSet) {
        activities.items.remove(atOffsets: offset)
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var activities = Activities()
    
    static var previews: some View {
        ActivitiesView(activities: activities)
    }
}
