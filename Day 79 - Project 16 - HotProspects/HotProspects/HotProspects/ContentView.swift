//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        List {
            ForEach(1...10, id: \.self) { number in
                Text("\(number)")
                    .swipeActions(edge: .leading) {
                        Button {
                            print("Hi, \(number)")
                        } label: {
                            Label("Send Message", systemImage: "message")
                                .tint(.blue)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            print("Deleting \(number)")
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
