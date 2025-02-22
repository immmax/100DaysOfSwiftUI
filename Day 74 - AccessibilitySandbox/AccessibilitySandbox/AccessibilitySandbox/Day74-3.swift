//
//  Day74-3.swift
//  AccessibilitySandbox
//
//  Created by Maxim Datskiy on 2/21/25.
//

import SwiftUI

struct Day74_3: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
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
}

#Preview {
    Day74_3()
}
