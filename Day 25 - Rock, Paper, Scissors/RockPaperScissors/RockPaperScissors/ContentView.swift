//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maxim Datskiy on 5/1/23.
//

import SwiftUI

struct MoveImage: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 50))
    }
}

struct ContentView: View {
    var moves = ["✊", "🖐", "✌️"]
    var winMoves = ["🖐", "✌️", "✊"]
    
    @State private var shouldWin = Bool.random()
    @State private var currentMove = Int.random(in: 0..<3)
    @State private var userChoice = ""
    @State private var score = 0
    
    @State private var showGameOver = false
    @State private var questionNumber = 0
    let maxQuestionNumber = 8
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Score: \(score)")
                Text("App's move: \(moves[currentMove])")
                Text("You should:  \(shouldWin ? "win" : "lose")")
            }
            .padding()
            
            HStack {
                ForEach(0..<3) { number in
                    Button {
                        moveTapped(winMoves[number], number)
                    } label: {
                        MoveImage(text: moves[number])
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
            }
            .padding()
        }
        .padding()
        .alert("Game Over", isPresented: $showGameOver) {
            Button("Start New Game", role: .cancel, action: reset)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func moveTapped(_ move: String, _ number: Int) {
        
        questionNumber += 1
        userChoice = move
        print("The user tapped \(userChoice)\nWin move: \(winMoves[number])")
        
        if userChoice == winMoves[number] {
            print("win move")
            switch shouldWin {
            case true: score += 1
            case false: score -= 1
            }
        } else {
            print("lose move")
            switch shouldWin {
            case true: score -= 1
            case false: score += 1
            }
        }
        
        if questionNumber == maxQuestionNumber {
            showGameOver = true
        }
        
        currentMove = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func reset() {
        score = 0
        questionNumber = 0
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
