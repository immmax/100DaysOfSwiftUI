//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Maxim Datskiy on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        NavigationSplitView(columnVisibility: .constant(.all)) {
        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {
            NavigationLink("Primary") {
                Text("New View")
            }
        } detail: {
            Text("Content")
//                .toolbar(.hidden, for: .navigationBar) // bad practice!
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ContentView()
}
