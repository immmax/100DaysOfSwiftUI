//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maxim Datskiy on 4/29/23.
//

import SwiftUI

struct FlagImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
        
    }
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.mint)
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingGameOver = false
    @State private var gameOverTitle = "Game Over"
    @State private var questionNumber = 0
    let maxQuestionNumber = 8
    
    @State private var animationAmount = 0.0
    @State private var userChoice: Int?
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
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
                        Text(countries[correctAnswer])
//                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            switch userChoice {
                            case nil:
                                FlagImage(text: countries[number].lowercased())
                            case number:
                                FlagImage(text: countries[number].lowercased())
                                    .rotation3DEffect(
                                        .degrees(animationAmount),
                                        axis: (x: 0, y: 1, z: 0))
                            default:
                                FlagImage(text: countries[number].lowercased())
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
                
                Text("Score: \(score)")
                    .foregroundColor(.white )
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(gameOverTitle, isPresented: $showingGameOver) {
            Button("Start New Game", action: reset)
                .buttonStyle(.borderedProminent)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
