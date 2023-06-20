//
//  ContentView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 5/22/23.
//

import SwiftUI

struct ContentView: View {
    let multiplicationTables = 2...12
    @State var questions = [String]()
    @State private var currentQuestion = 0
    
    @State private var selectedMultiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var score = 0
    
    @State private var showingMenu = true
    @State private var showingAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pink
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                    .navigationTitle("EDUtainment")
                if showingMenu {
                    VStack {
                        Stepper("Up to: \(selectedMultiplicationTable)",
                                value: $selectedMultiplicationTable,
                                in: multiplicationTables)
                        
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach([5, 10, 20], id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                        Spacer()
                        //Text("Your choice is:\n\nUp to \(selectedMultiplicationTable)\n\(numberOfQuestions) questions\nShowing menu: \(String(showingMenu))")
                        Spacer()
                        ForEach(questions, id:\.self) {
                            Text($0)
                        }
                    }
                    .padding()
                    .toolbar {
                        Button("New Game", action: startNewGame)
                            .buttonStyle(.borderedProminent)
                            .tint(.purple)
                    }
                } else {
                    VStack {
                        ForEach(0..<numberOfQuestions) {i in
                            Text(questions[i])
                        }
                        Text("What is \(questions[currentQuestion])")
                        Button("Answer") {
                            answerTapped(2)
                        }
                        .buttonStyle(.bordered)
//                        ForEach
                        
//                        TextField()
                    }
                    .padding()
                    .toolbar {
                        Button("End Game", role: .destructive, action: endGame)
                            .buttonStyle(.borderedProminent)
//                            .tint(.purple)
                    }
                    .alert(alertTitle, isPresented: $showingAlert) {
                        
                    } message: {
                        Text(alertMessage)
                    }
                }
                
            }
            
        }
    }
    
    func startNewGame() {
        showingMenu = false
        score = 0
        questions.reserveCapacity(numberOfQuestions)
        for _ in 1...numberOfQuestions {
            let new_question = "\(selectedMultiplicationTable) * \(Int.random(in: 1...12))"
            if !questions.contains(new_question) {
                questions.append(new_question)
            }
        }
    }
    
    func answerTapped(_ answer: Int) {
        if answer == 2 {
            score += 1
            alertTitle = "Good Job!"
            alertMessage = "Your score is \(score) now! Way to go!"
        } else {
            alertTitle = "Stop! Think twice!"
            alertMessage = "Your score is still \(score). Don't give uo!"
        }
        
        if currentQuestion < numberOfQuestions - 2 {
            currentQuestion += 1
        } else {
            endGame()
        }
        showingAlert = true
        
        
    }
    
    func endGame() {
        alertTitle = "Game Over"
        alertMessage = "Your score is \(score)!"
        questions.removeAll()
        //showingMenu = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
