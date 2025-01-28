//
//  HabitListCell.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct HabitListCell: View {
    var habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.title)
                    .font(.headline)
                    .bold()
                
                Text(habit.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("\(habit.completionCount)")
                .frame(minWidth: 50, alignment: .trailing)
        }
    }
    
    init(_ habit: Habit) {
        self.habit = habit
    }
}

#Preview {
    HabitListCell(MockData.habit)
}
