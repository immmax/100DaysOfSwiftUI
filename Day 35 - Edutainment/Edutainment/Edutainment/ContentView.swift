//
//  ContentView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 8/22/24.
//

import SwiftUI

struct ContentView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select a table")
                    .font(.title)
                    .padding(.bottom, 40)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(2..<13) { number in
                        NavigationLink(value: number) {
                            Text("\(number)")
                                .font(.title)
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.blue)
                                .background(.yellow.gradient.opacity(0.3))
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                }
            }
            .navigationTitle("Let's Multiply")
            .navigationDestination(for: Int.self) { selection in
                QuestionsAmountSelector(selectedTable: selection)
            }
        }
    }
}

#Preview {
    ContentView()
}
