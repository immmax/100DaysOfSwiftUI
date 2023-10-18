//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Maxim Datskiy on 10/18/23.
//

import SwiftUI

struct ContentView: View {
   
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Value: \(value)")
                .padding()
            
            HStack(spacing: 20) {
                Button("Decrement") {
                    value -= 1
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button("Increment") {
                    value += 1
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .decrement: value -= 1
            case .increment: value += 1
            default: print("Not handled")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
