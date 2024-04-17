//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Maxim Datskiy on 4/30/23.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .prominentTitle()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
