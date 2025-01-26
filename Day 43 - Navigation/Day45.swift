//
//  Day45.swift
//  Day 43 - Navigation
//
//  Created by Maxim Datskiy on 1/25/25.
//

import SwiftUI

struct Day45: View {
    @State private var title: String = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Item \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap Me") {
                            // button action here
                    }
                
                    Button("Or Tap Me") {
                            // button action here
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    Day45()
}
