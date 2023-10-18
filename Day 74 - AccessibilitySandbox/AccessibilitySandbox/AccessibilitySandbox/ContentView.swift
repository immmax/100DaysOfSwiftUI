//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        VStack {
            Image(decorative: pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
//                .accessibilityHidden(true)
            Text("Placeholder")
            Text("For accessibility")
        }
//        .accessibilityElement(children: .combine)
        .accessibilityElement() // .ignore by default
        .accessibilityLabel("Good placeholder for accessibility")
        
    }
}

#Preview {
    ContentView()
}
