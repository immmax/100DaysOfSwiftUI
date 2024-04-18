//
//  ThreeView.swift
//  Animations
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

struct ThreeView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(40)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1, y: 1, z: 1)
        )
    }
}

#Preview { ThreeView() }
