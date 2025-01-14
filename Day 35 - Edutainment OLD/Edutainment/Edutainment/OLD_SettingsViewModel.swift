//
//  SettingsViewModel.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/18/24.
//

import Foundation
import Observation

@Observable class SettingsViewModel {
    var showingPlayView = false
    
    let multiplicationTables = 2...12
    
    var selectedMultiplicationTable = 2
    var numberOfQuestions = 10
    
    var questions = [String]()
    
    func generateQuestions(_ count: Int) -> [String] {
        var questions: [String] = []
        
        while questions.count < count {
            let new_question = "\(selectedMultiplicationTable) * \(Int.random(in: 1...12))"
            questions.append(new_question)
        }
        return questions
    }
    
//    func startNewGame() {
//        generateQuestions(numberOfQuestions)
//    }
}
