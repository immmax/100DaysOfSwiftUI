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
    let students = [Student(name: "Michael Scott"), Student(name: "Jim Halpert")]
    
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
