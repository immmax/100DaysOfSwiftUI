//
//  MockData.swift
//  Breaking The Habits
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct MockData {
    var habits = Habits()
    
    init(habits: Habits = Habits()) {
        self.habits.items = MockData.habitItems
    }
    static let habit = Habit(title: "Morning Run", description: "Go for a 30-minute run every morning.")
    
    static let habitItems: [Habit] = [
        Habit(title: "Morning Run", description: "Go for a 30-minute run every morning."),
        Habit(title: "Read Books", description: "Read at least 20 pages of a book daily."),
        Habit(title: "Meditation", description: "Practice mindfulness meditation for 10 minutes each day."),
        Habit(title: "Drink Water", description: "Drink 8 glasses of water daily to stay hydrated."),
        Habit(title: "Learn a Skill", description: "Dedicate an hour daily to learning a new skill."),
        Habit(title: "Healthy Eating", description: "Eat a balanced diet with more vegetables and fruits."),
        Habit(title: "Sleep Schedule", description: "Go to bed and wake up at consistent times every day."),
        Habit(title: "Exercise", description: "Engage in a 30-minute workout or yoga session daily."),
        Habit(title: "Gratitude Journal", description: "Write down three things you're grateful for each day."),
        Habit(title: "Digital Detox", description: "Limit screen time to 2 hours in the evening.")
    ]
}

