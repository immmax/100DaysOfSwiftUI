//
//  Day44.swift
//  Day 43 - Navigation
//
//  Created by Maxim Datskiy on 1/25/25.
//
//import Observation
import SwiftUI

@Observable
class PathStore {
//    var path: [Int] {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
//            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//                path = decoded
                path = NavigationPath(decoded)
                return
            }
        }
        
//        path = []
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation path - \(error.localizedDescription)")
        }
    }
}

struct DetailView44: View {
//    @Binding var path: [Int]
    @Binding var path: NavigationPath
    
    var number: Any
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
//            .toolbar {
//                Button("Go Home") {
//                    path.removeAll()
//                    path = NavigationPath()
//                }
//            }
    }
}

struct Day44: View {
    
    //Part 3 and 4
//    @State private var path = [Int]()
//    @State private var path = NavigationPath()
    @State private var pathStore = PathStore()
    
    // Part 2
//    @State private var path = NavigationPath()
    
    // Part 1
//    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            // Part 3
            DetailView44(path: $pathStore.path, number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView44(path: $pathStore.path, number: i)
                }
            
            // Part 2
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number \(i)", value: i)
//                }
//                
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String \(i)", value: String(i))
//                }
//            }
//            .toolbar {
//                Button("Show 25") {
//                    path.append(25)   
//                }
//                
//                Button("Show smile") {
//                    path.append("😊")
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the string \(selection)")
//            }
            
            // Part 1
//            VStack {
//                Button("Show 32") {
//                    path = [32]
//                }
//                
//                Button("Show 64") {
//                    path.append(64)
//                }
//                
//                Button("Show 32 then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
        }
    }
}

#Preview {
    Day44()
}
