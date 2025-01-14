//
//  ContentView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 5/22/23.
//

import SwiftUI

struct OLD_ContentView: View {
    
   var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
//            ZStack {
//                if viewModel.showingMenu {
                    SettingsView()
//                } else {
//                    PlayView(multiplicationTable: viewModel., questions: viewModel.questions)
//                }
//            }
                .background(.purple.opacity(0.2).gradient)
            .navigationTitle("EDUtainment")
            
        }
    }
    
    //
    //    func endGame() {
    //        alertTitle = "Game Over"
    //        alertMessage = "Your score is \(score)!"
    //        questions.removeAll()
    //        //showingMenu = true
    //    }
    
}

#Preview {
    ContentView()
}


extension OLD_ContentView: SettingsViewDelegate {
    
    func startGameTapped(_ questions: [String]) {
        viewModel.questions = questions
        viewModel.score = 0
//        viewModel.showingMenu = false
    }
}

