//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Maxim Datskiy on 7/29/23.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    let students = [Student(name: "Michael Scott"), Student(name: "Jim Halpert")]
    
    var body: some View {
        VStack {
            List(students, id: \.self) { student in
                Text(student.name)
            }
            
            Button("Save") {
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
