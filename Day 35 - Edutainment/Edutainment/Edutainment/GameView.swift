//
//  GameView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 11/7/24.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var questions: [Question]
    @State private var questionIndex = 0
    @State private var score = 0
    @State private var userAnswer = ""
    @FocusState private var isFocused: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            ProgressView(value: Double(questionIndex + 1), total: Double(questions.count))
                .progressViewStyle(.linear)
            Text(questions[questionIndex].text)
                .font(.title)
            TextField("Your answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .submitLabel(.go)
                .onSubmit(checkAnswer)
            
            Button("Submit Answer") {
                checkAnswer()
            }
        }
        .multilineTextAlignment(.center)
        .onAppear {
            isFocused = true
        }
        .alert("Game Over", isPresented: $showAlert) {
            Button("New Game") {
                dismiss()
            }
        } message: {
            Text("You have \(score) correct answers out of \(questions.count)")
        }

    }
    
    func checkAnswer() {
        
        if userAnswer == questions[questionIndex].answer {
            score += 1
        }
        
        if questionIndex + 1 == questions.count {
            gameOver()
            return
        }
        
        userAnswer = ""
        questionIndex += 1
    }
    
    func gameOver() {
        showAlert = true
    }
}

#Preview {
    GameView(questions: .constant([Question(text: "Question Text", answer: "Answer")]))
}
