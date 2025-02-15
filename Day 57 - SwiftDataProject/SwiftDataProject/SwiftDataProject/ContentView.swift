//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Maxim Datskiy on 2/14/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<User> { user in
        if user.name.localizedStandardContains("S") {
            if user.city == "Seattle, WA" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }, sort: \User.name) var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Michael Scott", city: "Scranton, NY", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Max Datskiy", city: "Seattle, WA", joinDate: .now.addingTimeInterval(86400 * -50))
                    let third = User(name: "Johny English", city: "London, UK", joinDate: .now.addingTimeInterval(86400 * 5))
                    let forth = User(name: "Saul Goodman", city: "Albuquerque, WA", joinDate: .now.addingTimeInterval(86400 * 10))
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(forth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
