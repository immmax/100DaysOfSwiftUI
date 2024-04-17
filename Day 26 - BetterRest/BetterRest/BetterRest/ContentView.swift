//
//  ContentView.swift
//  BetterRest
//
//  Created by Maxim Datskiy on 5/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $viewModel.wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("Desired amount od sleep") {
                    Stepper("\(viewModel.sleepAmount.formatted()) hours", value: $viewModel.sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $viewModel.coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }
                
                Section("Calculated bedtime") {
                    Text(viewModel.calculatedBedtime)
                        .font(.title)
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: viewModel.calculateBedtime)
//            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview { ContentView() }
