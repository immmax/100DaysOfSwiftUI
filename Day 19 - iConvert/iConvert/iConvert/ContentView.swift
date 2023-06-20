//
//  ContentView.swift
//  iConvert
//
//  Created by Maxim Datskiy on 4/26/23.
//

import SwiftUI

let quantities = ["Length": ["m", "km", "ft", "yd", "mi"],
                  "Temperature": ["ºC", "ºF", "ºK"],
                  "Time": ["sec", "min", "hour", "day"],
                  "Volume": ["mL", "L", "c.", "pt.", "gal."]]

let coefficients = ["m": 1.0, "km": 1000.0, "ft": 0.3048, "yd": 0.9144, "mi": 1609.34,
                    "ºC": 1.0, "ºF": 9.0/5.0, "ºK": 273.15,
                    "sec": 1.0,  "min":60.0, "hour": 3600.0, "day": 86400.0,
                    "mL": 1.0, "L": 1000.0, "c.": 240, "pt.": 473.176, "gal.": 3785.41]


struct ContentView: View {
    @State private var quantity = "Length"
    @State private var firstUnit = ""
    @State private var secondUnit = ""
    @State private var inputValue: Double? = nil
    @FocusState private var inputIsFocused: Bool
    
    var outputValue: Double {
        let enteredValue = inputValue ?? 0
        let coeff1 = coefficients[firstUnit] ?? 1.0
        let coeff2 = coefficients[secondUnit] ?? 1.0
        
        var defaultValue: Double
        switch quantity {
        case "Temperature":
            switch firstUnit {
            case "ºC":
                defaultValue = enteredValue
            case "ºF":
                defaultValue = (enteredValue - 32) / coeff1
            case "ºK":
                defaultValue = enteredValue - coeff1
            default:
                defaultValue = enteredValue * coeff1
            }
        default:
            defaultValue = enteredValue * coeff1
        }
        
        var result: Double
        switch secondUnit{
        case "ºC":
            result = defaultValue / coeff2
        case "ºF":
            result = defaultValue * coeff2 + 32
        case "ºK":
            result = defaultValue + coeff2
        default:
            result = defaultValue / coeff2
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("I want to convert:", selection: $quantity) {
                        ForEach(quantities.keys.sorted(), id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("First unit", selection: $firstUnit) {
                        ForEach(quantities[quantity] ?? [""], id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select the first unit")
                }
                
                Section {
                    Picker("Second unit", selection: $secondUnit) {
                        ForEach(quantities[quantity] ?? [""], id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select the second unit")
                }
                
                Section {
                    TextField("Value to convert", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Input a value to convert")
                }
                
                Section {
                    Text("\(outputValue.formatted())")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture(count: 2) {
                            UIPasteboard.general.string = String(outputValue)
                            }
                } header: {
                    Text("Result")
                }
            }
            
            .navigationTitle("iConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
