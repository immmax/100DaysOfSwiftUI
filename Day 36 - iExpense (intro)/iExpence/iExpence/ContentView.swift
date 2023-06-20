//
//  ContentView.swift
//  iExpence
//
//  Created by Maxim Datskiy on 6/13/23.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Tough"
    @Published var lastName = "Guy"
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
    @StateObject var user = User()
    
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
                Spacer()
                List {
                    ForEach(numbers, id:\.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
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
                    SecondView(name: "@nickname")
                }
            }
            .padding()
            
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
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
