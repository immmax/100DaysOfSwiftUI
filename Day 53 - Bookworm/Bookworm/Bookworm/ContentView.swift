//
//  ContentView.swift
//  Bookworm
//
//  Created by Maxim Datskiy on 7/26/23.
//

import SwiftUI

struct PushButton: View {
    let title : String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
        
    }
    
}

struct ContentView: View {
    @State private var rememberMe = false
    
    @AppStorage("notes") private var notes = ""
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            VStack {
//                PushButton(title: "Remember Me", isOn: $rememberMe)
//                Text(rememberMe ? "On" : "Off")
//
//                TextEditor(text: $notes)
//                    .navigationTitle("Notes")
//                    .padding()
                
                List(students) { student in
                    Text("\(student.firstName ?? "Unknown") \(student.lastName ?? "Unknown")")
                }
                
                Button("Add student") {
                    let firstNames = ["Max", "Paul", "Sean", "Alex", "Dick", "Sally"]
                    let lastNames = ["Hudson", "Allen", "Datskiy", "Wallace", "McGregor"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.firstName = chosenFirstName
                    student.lastName = chosenLastName
                    
                    try? moc.save()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
