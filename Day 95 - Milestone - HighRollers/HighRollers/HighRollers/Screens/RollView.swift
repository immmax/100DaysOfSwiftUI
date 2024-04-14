//
//  RollView.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 4/13/24.
//

import SwiftUI

struct RollView: View {
    
    @State private var dice = 6
    @State private var rolls: [Roll] = []
    @State private var numberOfDice = 5
    
    @State var roll: Roll? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("You roll:")
                    .font(.title)
                    .padding(.top, 40)
                
                if roll != nil {
                    
                    Text(roll!.numbers, format: .list(memberStyle: .number, type: .and))
                        .padding()
                        .multilineTextAlignment(.center)
                        .transition(.identity)
                    
                    Text((String(roll?.numbers.reduce(0, +) ?? 0)))
                        .font(.largeTitle.bold())
                        .padding(.top, 50)
                        .lineLimit(1, reservesSpace: true)
                        .transition(.identity)
                        
                } else {
                    Text("")
                        .padding()
                        
                    Text("0")
                        .font(.largeTitle.bold())
                        .padding(.top, 50)
                        .lineLimit(1, reservesSpace: true)
                }
                
                
                Spacer()
                
                HStack(spacing: 50) {
                    VStack(spacing: 20) {
                        Text("Dice Type")
                            .font(.headline)
                        Button { dice += 1} label: {
                            Label("Increase", systemImage: "plus")
                                .labelStyle(.iconOnly)
                        }
                        .buttonRepeatBehavior(.enabled)
                        
                        
                        Text("\($dice.wrappedValue)")
                            .font(.largeTitle)
                        
                        Button {
                            dice -= 1
                        } label: {
                            Label("Decrease", systemImage: "minus")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(dice < 3)
                    }
                    
                    VStack(spacing: 20) {
                        Text("Dice Count")
                            .font(.headline)
                        Button { numberOfDice += 1} label: {
                            Label("Increase", systemImage: "plus")
                                .labelStyle(.iconOnly)
                        }
                        .buttonRepeatBehavior(.enabled)
                        .sensoryFeedback(.increase, trigger: numberOfDice)

                        
                        
                        Text("\($numberOfDice.wrappedValue)")
                            .font(.largeTitle)
                        
                        Button {
                            numberOfDice -= 1
                        } label: {
                            Label("Decrease", systemImage: "minus")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(numberOfDice < 2)
                    }
                }
                
                Spacer()
                
                Button("ROLL") {
                    withAnimation {
                        var numbers: [Int] = []
                        
                        for _ in 0..<numberOfDice {
                            numbers.append(Int.random(in: 1...dice))
                        }
                        
                        roll = Roll(date: .now, numbers: numbers)
                        print(roll!)
                        saveRoll(roll!)
                        rolls.append(roll!)
                    }
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .navigationTitle("Let's Roll")
        }
    }
    
    func saveRoll(_ roll: Roll) {
        Task {
            do {
                try PersistenceManager.save(newRoll: roll)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    RollView()
}
