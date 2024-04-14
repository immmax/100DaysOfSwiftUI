//
//  ContentView.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 3/11/24.
//

import SwiftUI

struct DiceTabView: View {
    
    var body: some View {
        TabView {
            RollView()
                .tabItem { Label("Roll", systemImage: "die.face.3") }
            
            HistoryView(rolls: [])
                .tabItem { Label("History", systemImage: "clock") }
        }
    }
}

#Preview {
    DiceTabView()
}
