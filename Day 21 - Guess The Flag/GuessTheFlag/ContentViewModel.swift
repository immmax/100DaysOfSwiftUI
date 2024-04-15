//
//  Model.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/14/24.
//

import SwiftUI
import Observation

@Observable final class ContentViewModel {
    
    var showingScore: Bool = false
    var scoreTitle: String = ""
    var score = 0
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var correctAnswer = Int.random(in: 0...2)
    var showingGameOver = false
    var gameOverTitle = "Game Over"
    var questionNumber = 0
    let maxQuestionNumber = 8
    
    var animationAmount = 0.0
    var userChoice: Int?
    
    
    func flagTapped(_ number: Int) {
        questionNumber += 1
        userChoice = number
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            //score -= 1 // Uncomment this, if you want decrease score in case of wrong answer.
        }
        
        withAnimation(.easeIn(duration: 0.5)) {
            animationAmount += 360
        }
        
        if questionNumber < maxQuestionNumber {
            showingScore = true
        } else {
            showingGameOver = true
        }
    }
    
    
    func askQuestion() {
        userChoice = nil
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    func reset() {
        score = 0
        questionNumber = 0
        userChoice = nil
    }
}
