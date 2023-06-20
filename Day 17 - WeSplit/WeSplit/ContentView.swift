//
//  ContentView.swift
//  WeSplit
//
//  Created by Maxim Datskiy on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPersentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var systemCurrency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    let tipPersentages = 0..<101
    
    var grandTotal: Double {
        let tipSelection = Double(tipPersentage)
        let tipValue = checkAmount / 100 * tipSelection
        let Total = checkAmount + tipValue
        return Total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(02..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPersentage) {
                        ForEach(tipPersentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tips do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: systemCurrency)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(grandTotal, format: systemCurrency)
                        .foregroundColor(tipPersentage == 0 ? .red : .black)
                } header: {
                    Text("Grang Total")
                }
                    
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
