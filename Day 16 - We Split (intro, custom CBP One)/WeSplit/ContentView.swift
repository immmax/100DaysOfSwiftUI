//
//  ContentView.swift
//  WeSplit
//
//  Created by Maxim Datskiy on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    @State private var selectedPort = ""
    
    let portsOfEntry = [
        "Brownsville (Gateway Bridge)",
        "Calexico West (Downtown - Pedestrian)",
        "Eagle Pass (Camino Real International Bridge",
        "Hidalgo (International Bridge)",
        "Laredo (Gateway to American Bridge)",
        "Nogales",
        "Paso Del Norte",
        "San Ysidro Pedestrian West (El Chaparral)"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select a port of entry", selection: $selectedPort) {
                    ForEach(portsOfEntry, id: \.self) { Text($0) }
                }
            }
            .navigationTitle("CBP One - My Version")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
