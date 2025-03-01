//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Max", "Kevin", "Rob", "John", "David", "Sarah", "Alex", "Emma", "Michael", "Liam"]
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                name.localizedStandardContains(searchText)
//                $0.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something...")
            .navigationTitle("Searching")
        }
    }
}

#Preview {
    ContentView()
}
