//
//  ContentView.swift
//  Moonshot
//
//  Created by Maxim Datskiy on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State private var showingGrid = true
    @State private var searchMission = ""
    @State private var showingAllMissions = true
    
    let files: () = FileManager.default.copyFilesFromBundle(
        [
            "astronauts.json",
            "missions.json"
        ]
    )
    let missions: [Mission] = FileManager.default.decode("missions.json")
    let astronauts: [String: Astronaut] = FileManager.default.decode("astronauts.json")
    
    var filteredMissions: [Mission] {
        guard !searchMission.isEmpty else {return missions}
        return missions.filter { $0.displayName.localizedCaseInsensitiveContains(searchMission) }
    }
    
    var body: some View {
        
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(missions: filteredMissions,
                               astronauts: astronauts
                    )
                } else {
                    ListLayout(
                        missions: filteredMissions,
                        astronauts: astronauts
                    )
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(showingGrid ? "Show List" : "Show Grid") {
                    showingGrid.toggle()
                }
                .buttonStyle(.bordered)
            }
            .searchable(
                text: $searchMission,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search a mission"
            ) { }
        }
    }
}

#Preview {
    ContentView()
}
