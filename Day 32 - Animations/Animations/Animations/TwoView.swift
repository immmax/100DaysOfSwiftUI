//
//  TwoView.swift
//  Animations
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

struct TwoView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Spacer()
            
            Stepper("Animation amount", value: $animationAmount.animation(
                .easeInOut(duration: 0.5)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            
            Spacer()
        }
        .padding()
    }
}

#Preview { TwoView() }
