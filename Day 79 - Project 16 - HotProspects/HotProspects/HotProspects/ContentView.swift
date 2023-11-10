//
//  ContentView.swift
//  HotProspects
//
//  Created by Maxim Datskiy on 10/26/23.
//

import SamplePackage
import SwiftUI

struct ContentView: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        Text(results)
    }
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        
        return strings.joined(separator: ", ")
    }
}

#Preview {
    ContentView()
}
