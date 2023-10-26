//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    static let tag = "ContentView"  // or "HomeView" or whatever
    @State private var selectedTab = "Two"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .padding(50)
                .background(.bar)
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("One")
            Text("Tab 2")
                .padding(50)
                .background(.bar)
                .onTapGesture {
                    selectedTab = "Three"
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag("Two")
            Text("Tab 3")
                .padding(50)
                .background(.bar)
                .onTapGesture {
                    selectedTab = "One"
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag("Three")
        }
    }
}

#Preview {
    ContentView()
}
