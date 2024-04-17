//
//  ContentViewModel.swift
//  RockPaperScissors
//
//  Created by Maxim Datskiy on 4/17/24.
//

import Foundation
import Observation

@Observable class ContentViewModel {
    
    var shouldWin = Bool.random()
    var appMove = Int.random(in: 0..<3)
    var userChoice: Int?
    var score = 0
    var questionNumber = 0
    
    var showGameOver = false
    
    let maxQuestionNumber = 10
    let moves = ["✊", "🖐", "✌️"]
    let winMoves = ["🖐", "✌️", "✊"]
    
    
    func moveTapped(_ userMove: Int) {
        questionNumber += 1
        
        if shouldWin {
            if userMove == appMove {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if userMove != appMove {
                score += 1
            } else {
                score -= 1
            }
        }
        
        checkQuestionNumber()
        nextMove()
    }
    
    
    func checkQuestionNumber() {
        guard questionNumber != maxQuestionNumber else {
            showGameOver = true;
            return
        }
    }
    
    
    func nextMove() {
        appMove = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    
    func reset() {
        score = 0
        questionNumber = 0
    }
}
