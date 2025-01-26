//
//  Day43.swift
//  Day 43 - Navigation
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct DetailView: View {
    var number: Int
    
    var body: some View {
        Text("You selected \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

struct Day43: View {
    var body: some View {
        List(0..<100) { i in
            NavigationLink("Select \(i)", value: i)
        }
        .padding()
        .navigationDestination(for: Int.self) { selection in
            DetailView(number: selection)
        }
        .navigationDestination(for: Student.self) { student in
            Text(student.name)
        }
    }
}

#Preview {
    Day43()
}
