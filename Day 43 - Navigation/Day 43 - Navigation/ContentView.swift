//
//  ContentView.swift
//  Day 43 - Navigation
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Day 43") { Day43() }
            NavigationLink("Day 44") { Day44() }
            NavigationLink("Day 45") { Day45() }
//            NavigationLink("Day 46") { Day46() }
        }
    }
}

#Preview {
    ContentView()
}
