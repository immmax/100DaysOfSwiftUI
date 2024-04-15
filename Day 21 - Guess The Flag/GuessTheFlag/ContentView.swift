//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            //            RadialGradient(stops: [
            //                Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            //                Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            //            ], center: .top, startRadius: 200, endRadius: 700)
            //                .ignoresSafeArea()
            
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .titleStyle()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(viewModel.countries[viewModel.correctAnswer])
                        //                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            viewModel.flagTapped(number)
                        } label: {
                            switch viewModel.userChoice {
                            case nil:
                                FlagImageView(text: viewModel.countries[number].lowercased())
                            case number:
                                FlagImageView(text: viewModel.countries[number].lowercased())
                                    .rotation3DEffect(
                                        .degrees(viewModel.animationAmount),
                                        axis: (x: 0, y: 1, z: 0))
                            default:
                                FlagImageView(text: viewModel.countries[number].lowercased())
                                    .opacity(0.25)
                                    .scaleEffect(0.5)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .foregroundColor(.white )
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            Button("Continue", action: viewModel.askQuestion)
        } message: {
            Text("Your score is \(viewModel.score)")
        }
        .alert(viewModel.gameOverTitle, isPresented: $viewModel.showingGameOver) {
            Button("Start New Game", action: viewModel.reset)
                .buttonStyle(.borderedProminent)
        } message: {
            Text("Your score is \(viewModel.score)")
        }
    }
}


#Preview {
    ContentView()
}
