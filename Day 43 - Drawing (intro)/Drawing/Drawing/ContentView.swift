//
//  ContentView.swift
//  Drawing
//
//  Created by Maxim Datskiy on 6/23/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Spacer()
                    
                    ForEach(1..<5, id: \.self) { number in
                        NavigationLink {
                                DayView(number)
                        } label: {
                            Text("Part \(number)")
                                .font(.headline)
                                .padding()
                                .frame(width: 250)
                                .foregroundColor(.primary)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Project 8 - Drawing")
//            .foregroundColor(.primary)
            .preferredColorScheme(.dark)
            .background(
                AngularGradient(
                    colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple],
                    center: .center
                )
                .blur(radius: 20)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
