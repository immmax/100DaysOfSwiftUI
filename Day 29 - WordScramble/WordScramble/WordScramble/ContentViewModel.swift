//
//  ContentViewModel.swift
//  WordScramble
//
//  Created by Maxim Datskiy on 4/17/24.
//

import SwiftUI
import Observation
import UIKit

@Observable class ContentViewModel {
    
    var usedWords = [String]()
    var rootWord = ""
    var newWord = ""
    
    var errorTitle = ""
    var errorMessage = ""
    var showingError = false
    
    var score = 0
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else {
            wordError(title: "Too short", message: "Try to find a word longer that 3 symbols")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Cheater", message: "Don't use the root word")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell like this from '\(rootWord)'")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += newWord.count * usedWords.endIndex
        newWord = ""
    }
    
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: .newlines)
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                usedWords = []
                return
            }
        }
        
        fatalError("Couldn't load start.txt from bundle.")
    }
    
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos )
            } else {
                return false
            }
        }
        return true
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}
