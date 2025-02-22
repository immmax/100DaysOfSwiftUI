//
//  ContentView.swift
//  WordScramble
//
//  Created by Maxim Datskiy on 5/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $viewModel.newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Your total score") {
                    Text("\(viewModel.score)")
                        .font(.title)
                }
                
                Section("Used words") {
                    ForEach(viewModel.usedWords, id: \.self) { word in
                        Label(word, systemImage: "\(word.count).circle")
                            .accessibilityElement()
                            .accessibilityLabel(word)
                            .accessibilityHint("\(word.count) letters")
                    }
                }
                
                .accessibilityElement()
                .accessibilityLabel("Your score is \(viewModel.score)")
            }
            .navigationTitle(viewModel.rootWord)
            .onSubmit(viewModel.addNewWord)
            .onAppear(perform: viewModel.startGame)
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) { } message: {
                Text(viewModel.errorMessage)
            }
            .toolbar {
                Button("New Game", action: viewModel.startGame)
            }
        }
    }
}

#Preview { ContentView() }
