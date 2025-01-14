//
//  PlayView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

struct PlayView: View {
    
    @State private var viewModel = PlayViewModel()
//    var multiplicationTable: Int
    var questions: [String] = ["1 * 3"]
    
    var question: String {
        print(questions.first ?? "No questions")
        return questions.first ?? "No more questions"
    }
    
    var answers: [Int] {
        generateAnswers()
    }
    var body: some View {
        VStack {
//            CustomProgressView(progress: 0.1)
//                .onTapGesture {
//                    if viewModel.progress < 1 {
//                        withAnimation {
//                            viewModel.progress += 0.1
//                        }
//                    }
//                }
            
            Text(question)
                .font(.largeTitle)
            
            CustomGridView(numbers: answers.shuffled())
            
        }
        .padding()
        .onAppear {
            print(question)
            print(answers)
        }
//        VStack {
//            ForEach(0..<numberOfQuestions) { i in
//                Text(questions[i])
//            }
//            Text("What is \(questions[currentQuestion])")
//            Button("Answer") {
//                answerTapped(2)
//            }
//            .buttonStyle(.bordered)
//
//        }
//        .padding()
//        .toolbar {
//            Button("End Game", role: .destructive, action: endGame)
//                .buttonStyle(.borderedProminent)
//        }
//        .alert(alertTitle, isPresented: $showingAlert) {
//            
//        } message: {
//            Text(alertMessage)
//        }
    }
    
    
    func generateAnswers() -> [Int] {
        if question != "No more questions" {
            var answersArray = [Int]()
            
            answersArray.append((Int(question.prefix(2)) ?? 1) * (Int(question.suffix(2)) ?? 1))
            
            while answersArray.count < 5 {
                answersArray.append((Int(question.prefix(2)) ?? 1) * Int.random(in: 2...12))
            }
            
            return answersArray
        } else {
            return []
        }
    }
}

#Preview { PlayView(questions: []) }
