//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maxim Datskiy on 5/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("You should: \t\(viewModel.shouldWin ? "WIN" : "LOSE")")
                Text("App's move: \t\(viewModel.moves[viewModel.appMove])")
            }
            .font(.title)
            .padding()
            
            HStack {
                ForEach(0..<3) { number in
                    Button {
                        viewModel.moveTapped(number)
                    } label: {
                        MoveImageView(viewModel.winMoves[number])
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
            }
            .padding()
            
            Text("Score: \t\t\t\(viewModel.score)")
                .font(.title)
        }
        .padding()
        .alert("Game Over", isPresented: $viewModel.showGameOver) {
            Button("Start New Game", role: .cancel, action: viewModel.reset)
        } message: {
            Text("Your score is \(viewModel.score)")
        }
    }    
}


#Preview {
    ContentView()
}
