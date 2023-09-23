//
//  ContentView.swift
//  BucketList
//
//  Created by Maxim Datskiy on 9/20/23.
//

import SwiftUI


struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    
    // This provides conformance to Comparable (not the same as Equatable!)
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

#Preview {
    ContentView()
}
