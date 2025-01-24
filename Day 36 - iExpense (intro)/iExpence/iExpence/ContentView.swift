//
//  ContentView.swift
//  iExpence
//
//  Created by Maxim Datskiy on 6/13/23.
//

import Observation
import SwiftUI

@Observable
class User: Codable {
    var firstName = "Ivan"
    var lastName = "Somov"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Spacer()
        Text("Hello \(name)")
        Spacer()
        Button("Dismiss") {
            dismiss()
        }
        .buttonStyle(.bordered)
//        Spacer()
        
        
    }
}
struct ContentView: View {
    @State private var user = User()
    
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName)")
                TextField("First name:", text: $user.firstName)
                TextField("Last name:", text: $user.lastName)
                
                Button("Save user") {
                    if let data = try? JSONEncoder().encode(user) {
                        UserDefaults.standard.set(data, forKey: "user")
                    }
                }
                
                Spacer()
                
                List {
                    ForEach(numbers, id:\.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                .listStyle(.plain)
                
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button("Tap count \(tapCount)", role: .destructive) {
                    tapCount += 1
//                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                }
                .buttonStyle(.borderedProminent)
                Spacer()
                Button("Show second sheet") {
                    showingSheet.toggle()
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showingSheet) {
                    SecondView(name: "@datskiy_dev")
                }
            }
            .padding()
            
            .navigationTitle("Day 36")
            .toolbar {
                EditButton()
            }
            .onAppear {
                if let data = UserDefaults.standard.object(forKey: "user") {
                    user = try! JSONDecoder().decode(User.self, from: data as! Data)
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
