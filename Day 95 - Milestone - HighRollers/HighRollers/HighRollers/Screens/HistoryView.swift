//
//  HistoryView.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 4/13/24.
//

import SwiftUI

struct HistoryView: View {
    
    @State var rolls: [Roll]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    ForEach(rolls.reversed()) { roll in
                        RollCell(roll)
                    }
                }
                .navigationTitle("History")
                .onAppear { getRolls() }
                
                if rolls.isEmpty {
                    ContentUnavailableView(
                        "No Rolls",
                        systemImage: "clock",
                        description: Text("Roll the dice on Roll screen.")
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func getRolls() {
        do {
            rolls = try PersistenceManager.retrieveRolls()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    HistoryView(rolls: [])
}
