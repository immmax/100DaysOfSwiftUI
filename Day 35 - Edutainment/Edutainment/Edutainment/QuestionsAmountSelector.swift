//
//  QuestionsAmountSelector.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 11/7/24.
//

import SwiftUI

struct QuestionsAmountSelector: View {
    @Environment(\.dismiss) var dismiss
    @State private var numberOfQuestions = 5
    @State private var questions = [Question]()
    @State private var isGameActive = false
    
    let selectedTable: Int
    
    var body: some View {
        VStack {
            Text("\(selectedTable) x")
                .font(.largeTitle.bold())
                .padding(50)
            
            Spacer()
            
            Text("How many questions would you like to practice?")
            
            HStack {
                Button {
                    numberOfQuestions -= 1
                } label: {
                    Label("Decrease", systemImage: "minus")
                        .frame(width: 44, height: 44)
                }
                .disabled(numberOfQuestions <= 1)
                
                Text("\(numberOfQuestions)")
                    .font(.largeTitle)
                
                Button {
                    numberOfQuestions += 1
                } label: {
                    Label("Increase", systemImage: "plus")
                        .frame(width: 44, height: 44)
                }
            }
            .labelStyle(.iconOnly)
            
            Spacer()

            Button {
                questions = generateQuestions()
                isGameActive = true
            } label: {
                Text("Let's Multiply")
                    .frame(width: 400, height: 100)
                    .background(Color.green.gradient)
                    .clipShape(.rect(cornerRadius: 20))
                    .foregroundStyle(.white)
                    .padding(.top, 150)
            }
            
        }
        .fullScreenCover(isPresented: $isGameActive, onDismiss: { dismiss() }) {
            GameView(questions: $questions)
        }
    }
    
    func generateQuestions() -> [Question] {
        // Генерирует указанное число вопросов. Первые 12 - уникальные, далее - повторяются.
        var generatedQuestions = [Question]()
        var usedMultipliers = Set<Int>()
        
        while generatedQuestions.count < numberOfQuestions {
            let multiplier = Int.random(in: 1...12)

            if !usedMultipliers.contains(multiplier) {
                let newQuestion = Question(text: "\(selectedTable) * \(multiplier)", answer: "\(selectedTable *  multiplier)")
                generatedQuestions.append(newQuestion)
                usedMultipliers.insert(multiplier)
            }
            
            if usedMultipliers.count == 12 {
                usedMultipliers.removeAll()
            }
        }
        
        return generatedQuestions
    }
    
}

#Preview {
    QuestionsAmountSelector(selectedTable: 6)
}
