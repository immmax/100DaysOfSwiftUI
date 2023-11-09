//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(backgroundColor)
            .ignoresSafeArea()
            .contextMenu {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
            }
    }
}

#Preview {
    ContentView()
}
