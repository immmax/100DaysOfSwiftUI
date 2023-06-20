//
//  ContentView.swift
//  Animations
//
//  Created by Maxim Datskiy on 5/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
//            animationAmount += 0.5
        }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
//                            .repeatCount(3, autoreverses: false),
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount += 2
            }
//            .scaleEffect(animationAmount)
//            .blur(radius: (animationAmount - 0.5) * 3)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
