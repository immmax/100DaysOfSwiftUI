//
//  SettingsView.swift
//  Edutainment
//
//  Created by Maxim Datskiy on 4/18/24.
//

import SwiftUI

protocol SettingsViewDelegate {
    func startGameTapped(_ questions: [String])
}

struct SettingsView: View {
    
    @State private var viewModel = SettingsViewModel()
//    var delegate: SettingsViewDelegate
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select multiplication table") {
                    Stepper("\(viewModel.selectedMultiplicationTable)",
                            value: $viewModel.selectedMultiplicationTable,
                            in: viewModel.multiplicationTables)
                }
                
                Section("How many questions do you want?") {
                    Picker("Number of questions", selection: $viewModel.numberOfQuestions) {
                        ForEach([5, 10, 20], id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .padding()
            
            Button("Start Game", action: {
//                let questions = viewModel.generateQuestions(viewModel.numberOfQuestions)
                //                delegate.startGameTapped(questions)
                viewModel.showingPlayView = true
                viewModel.questions = viewModel.generateQuestions(viewModel.numberOfQuestions)
            } )
                .buttonStyle(.borderedProminent)
        }
        .toolbar {
            Button("New Game", action: { viewModel.showingPlayView = true } )
                .buttonStyle(.borderedProminent)
                .tint(.purple)
        }
        .fullScreenCover(isPresented: $viewModel.showingPlayView) {
            PlayView(questions: viewModel.questions)
        }
    }
}

#Preview { SettingsView() }
