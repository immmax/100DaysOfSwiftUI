//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: [SortDescriptor<Resort>] = []
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts.sorted(using: sortOrder)
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }.sorted(using: sortOrder)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                                
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort:  resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu {
                    Button("By Default") { sortOrder = [] }
                    Button("By Name") { sortOrder = [SortDescriptor(\Resort.name)] }
                    Button("By Country") { sortOrder = [SortDescriptor(\Resort.country)] }
                } label: {
                    Label("Sort", systemName: "arrow.up.arrow.down")
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
